
import Foundation
import UIKit




class FindDriverViewController : UIViewController {
    
    //경과시간 초기값
    var intcount = 0
    
    
    
    @IBOutlet weak var searchView: UIImageView!
    @IBOutlet weak var mainTimeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var backToMenu: UIButton!
    
    
    override func viewWillAppear(_ animated: Bool) {
        startTimer()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    
    //타이머 객체 만들기
    var timer : Timer?
    
    // viewdidLoad에서 스타트 타이머 timeInterval이 60되야 1분씩 카운팅
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCallback), userInfo: nil, repeats: true)
        
    }
    
    // 1분 카운팅완료 후 화면 텍스트에 증가 5분넘으면 스탑 타이머 걸림
    @objc func timerCallback() {
        
        UIView.animate(withDuration: 0.5, delay: 0, animations: {
            self.searchView.transform = CGAffineTransform(rotationAngle: .pi*0.25)
        })
        UIView.animate(withDuration: 1, delay: 0, animations: {
            self.searchView.transform = CGAffineTransform(rotationAngle: .pi*0.5)
        })
        UIView.animate(withDuration: 0.5, delay: 0, animations: {
            self.searchView.transform = CGAffineTransform(rotationAngle: .pi*0.75)
        })
        UIView.animate(withDuration: 1, delay: 0, animations: {
            self.searchView.transform = CGAffineTransform(rotationAngle: .pi*2)
        })
        mainTimeLabel.text = String(intcount)
        timeLabel.text = String(intcount)
        intcount += 1 //
        if intcount > 9 {
            stopTimer()
            //
            showAlert(tittle: "검색 시간 초과", content: "최대 9분거리 드라이버를 못 찾았어요!!", okBtb: "돌아가기", noBtn: "") // 팝업창 호출
        }
    }
    func stopTimer(){
        //타이머 중지
        if timer != nil && timer!.isValid {
            timer!.invalidate()
        }
    }
    
    func showAlert(tittle:String, content:String, okBtb:String, noBtn:String) {
        
        let alert = UIAlertController(title: tittle, message: content, preferredStyle: UIAlertController.Style.alert)
        if(okBtb != "" && okBtb.count>0){
            let okAction = UIAlertAction(title: okBtb, style: .default) { (action) in
                return
            }
            alert.addAction(okAction)
        }
        if(noBtn != "" && noBtn.count>0){
            let noAction = UIAlertAction(title: noBtn, style: .default) { (action) in
                return
            }
            alert.addAction(noAction)
        }
        present(alert, animated: false, completion: nil)
        
    }
    
}
