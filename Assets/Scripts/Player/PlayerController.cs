using System;
using System.Collections;
using TMPro;
using UnityEngine;

public class PlayerController : MonoBehaviour
{
    public float playerSpeed = 5f;
    public float jumpHeight = 2f;
    
    private float startYCoord;
    private bool isJumping;

    private void Start(){
        startYCoord = transform.position.y;
    }

    // Update is called once per frame
    void Update()
    {
        transform.position += new Vector3(Input.GetAxis("Horizontal"), 0, Input.GetAxis("Vertical")) * (playerSpeed * Time.deltaTime);
        if (Input.GetKey(KeyCode.Space) && !isJumping){
            isJumping = true;
            StartCoroutine(jump());
        }
    }

    IEnumerator jump(){
        Debug.Log("Jumping\n");
        while (transform.position.y < (startYCoord + jumpHeight)){
            transform.position = new Vector3(transform.position.x,transform.position.y + 3, transform.position.z );
            yield return new WaitForSeconds(0.01f);
        }
        while (transform.position.y > startYCoord){
            transform.position = new Vector3(transform.position.x,transform.position.y -5, transform.position.z );
            yield return new WaitForSeconds(0.01f);
        }
        isJumping = false;
    }
}
