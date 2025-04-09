import sys
import os
import platform
from PyQt5.QtWidgets import QApplication, QLabel, QWidget
from PyQt5.QtCore import Qt, QTimer, QSize, QPropertyAnimation, QPoint
from PyQt5.QtGui import QPixmap, QPainter

class TransparentWindow(QWidget):
    def __init__(self, image_folder):
        super().__init__()
        self.setWindowFlags(
            Qt.FramelessWindowHint |
            Qt.WindowStaysOnTopHint
        )
        self.setAttribute(Qt.WA_TranslucentBackground)

        self.label = QLabel(self)
        self.label.setAlignment(Qt.AlignCenter)

        self.images = sorted(
            (os.path.join(image_folder, img) for img in os.listdir(image_folder) if img.endswith(".png")),
            key=lambda x: int(os.path.splitext(os.path.basename(x))[0])
        )
        self.frame = 0

        self.timer = QTimer(self)
        self.timer.timeout.connect(self.update_frame)
        self.timer.start(100)

        self.update_frame()
        self.resize(100, 100)
        self.label.resize(self.size())

        self.move_to_bottom_center()

    def update_frame(self):
        self.frame = (self.frame + 1) % len(self.images)
        pixmap = QPixmap(self.images[self.frame])
        if pixmap.isNull():
            print(f"Failed to load image: {self.images[self.frame]}")
            return

        scaled_pixmap = pixmap.scaled(
            self.size(),
            Qt.KeepAspectRatio,
            Qt.SmoothTransformation
        )
        self.label.setPixmap(scaled_pixmap)
        self.label.repaint()

    def move_to_bottom_center(self):
        screen = QApplication.primaryScreen().geometry()
        x = (screen.width() - self.width()) // 7 - 75
        y = screen.height() - self.height() - 48 if platform.system() == "Darwin" else screen.height() - self.height() - 39
        self.move(x, y)

if __name__ == "__main__":
    app = QApplication(sys.argv)

    image_folder = "./anim/"
    window = TransparentWindow(image_folder)
    window.show()

    sys.exit(app.exec_())
