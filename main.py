import sys
import os
from PyQt5.QtWidgets import QApplication, QLabel, QWidget
from PyQt5.QtCore import Qt, QTimer, QSize, QPropertyAnimation, QPoint
from PyQt5.QtGui import QPixmap, QPainter

class TransparentWindow(QWidget):
    def __init__(self, image_folder):
        super().__init__()
        self.setWindowFlags(Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint | Qt.Tool)
        self.setAttribute(Qt.WA_TranslucentBackground)

        self.label = QLabel(self)
        self.label.setAlignment(Qt.AlignCenter)

        self.images = sorted([
            os.path.join(image_folder, img) for img in os.listdir(image_folder)
            if img.endswith(".png")
        ])
        self.frame = 0

        self.timer = QTimer(self)
        self.timer.timeout.connect(self.update_frame)
        self.timer.start(100)  # change for faster/slower animation

        self.update_frame()
        self.resize(200, 200)  # Change size based on your image

        self.move_to_bottom_center()

    def update_frame(self):
        pixmap = QPixmap(self.images[self.frame])
        self.label.setPixmap(pixmap.scaled(self.size(), Qt.KeepAspectRatio, Qt.SmoothTransformation))
        self.frame = (self.frame + 1) % len(self.images)

    def move_to_bottom_center(self):
        screen = QApplication.primaryScreen().geometry()
        x = (screen.width() - self.width()) // 2
        y = screen.height() - self.height() - 10  # 10 px above the Dock
        self.move(x, y)

if __name__ == "__main__":
    app = QApplication(sys.argv)

    image_folder = "/path/to/your/png_frames"  # Replace with your folder path
    window = TransparentWindow(image_folder)
    window.show()

    sys.exit(app.exec_())
