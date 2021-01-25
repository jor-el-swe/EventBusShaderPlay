using EventBrokerFolder;
using UnityEngine;

public class EventPublisher : MonoBehaviour
{
    // Start is called before the first frame update
    void Start(){
        int health = 3;
        int age = 4;
        EventBroker.Instance().SendMessage(health);
        EventBroker.Instance().SendMessage(new PlayerHealthMessage(10));
    }
}
