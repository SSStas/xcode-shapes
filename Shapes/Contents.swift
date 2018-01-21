import UIKit

class SwiftPlaygrounds {
    let view = Canvas.shared.backingView
    
    func run() {
        let circle = Circle(radius: 8)
        circle.center.y += 28
        
        let rectangle = Rectangle(width: 8, height: 5, cornerRadius: 0.5)
        rectangle.color = #colorLiteral(red: 0.192750853, green: 1, blue: 0, alpha: 0.5)
        rectangle.center.y += 15
        
        let line = Line(start: Point(x: -10 , y: 9), end: Point(x: 10 , y: 9), thickness: 0.9)
        line.center.y -= 15
        line.rotation = 170 * (Double.pi / 180)  // (Double.pi / 180) - поворот на 1 градус
        line.color = #colorLiteral(red: 1, green: 0.9025665347, blue: 0.1883900849, alpha: 1)
        
        
        let text = Text(string: "Hello, world! 💡", fontSize: 30, fontName: "copperplate", color: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1))
        text.center.y -= 2
        
        let image = Image(url: "https://upload.wikimedia.org/wikipedia/commons/4/47/PNG_transparency_demonstration_1.png")
        image.center.y -= 15
        image.size.height *= 0.5
        
        let numRectangles = 10
        var xOffset = Double(-numRectangles / 2)
        var yOffset = -26.0
        let saturationEnd = 0.991
        let saturationStart = 0.1
        let saturationStride = (saturationEnd - saturationStart) / Double(numRectangles)
        
        var saturation = saturationStart
        
        
        var when = DispatchTime.now() + .seconds(2)
        
        for i in 1...numRectangles  {
            DispatchQueue.main.asyncAfter(deadline: when, execute: {
                
                let rectangle2 = Rectangle(width: 8, height: 5, cornerRadius: 0.5)
                rectangle2.color = Color(hue: 0.079, saturation: saturation, brightness: 0.934)
                saturation += saturationStride
                rectangle2.center = Point(x: xOffset, y: yOffset)
                xOffset += 1
                yOffset += 1
                
            })
            when = DispatchTime.now() + .seconds(2 * (i+1) )
        }
        
        circle.onTouchDown {
            circle.color = circle.color.darker()
            circle.dropShadow = Shadow()
        }
        
        
        
        circle.onTouchUp {
            circle.color = Color.random()
            circle.dropShadow = nil
        }
        
        Canvas.shared.onTouchUp {
            circle.center = Canvas.shared.currentTouchPoints.first!
        }
        
        text.onTouchUp {
            animate(duration: 0.4) {
                line.rotation += 25 * (Double.pi / 180)  // (Double.pi / 180) - поворот на 1 градус
            }
            animate {
                text.string = "Привет, мир!"
            }
        }
    }
}
