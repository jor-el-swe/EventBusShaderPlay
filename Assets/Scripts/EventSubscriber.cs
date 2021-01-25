using UnityEngine;
using EventBrokerFolder;

public class EventSubscriber : MonoBehaviour{
    
    // Start is called before the first frame update
    void Awake(){
        EventBroker.Instance().SubscribeMessage<int>(PlayerAgeView);
        EventBroker.Instance().SubscribeMessage<int>(PlayerHealthView);
 
        EventBroker.Instance().SubscribeMessage<PlayerHealthMessage>(PlayerHealthView);
    }
    
    void PlayerHealthView(PlayerHealthMessage message){
        Debug.Log("player health from message class is: " + message.Health);
    }
    
    void PlayerHealthView(int message){
        Debug.Log("player health is: " + message);
    }
    
    void PlayerAgeView(int message){
        Debug.Log("player age is: " + message);
    }

}
    

