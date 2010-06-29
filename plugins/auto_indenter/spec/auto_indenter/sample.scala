package ch.mollusca.stomp.frame

import org.scalatest.Spec

class FrameProcessorSpec extends Spec {

  val frameProcessor = new FrameProcessor
  
  describe("The frame processor") {
    it("should handle a complete CONNECT frame") {
      assert(frame.content === "message body.")
    }
  }
}