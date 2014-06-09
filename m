From: Gordon Hollingworth <gordon@raspberrypi.org>
Subject: PWM DMA interface
Date: Mon, 9 Jun 2014 10:49:46 +0000
Message-ID: <CFBB4FD9.4313A%gordon@raspberrypi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail1.bemta5.messagelabs.com ([195.245.231.143]:34869 "EHLO
	mail1.bemta5.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752027AbaFIK4c convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Mon, 9 Jun 2014 06:56:32 -0400
Content-Language: en-US
Content-ID: <6B16358992A5054EAE45C91700B1CED2@hs20.net>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>

Hi,

I've been writing a driver that uses the PWM to talk to devices that
communicate through a pwm like signal.  To achieve this some devices have
a dma interface that you can stream data at to the pwm...

We use something similar to this on Raspberry Pi to do audio output, we
use the PWM interface to output a 'stream' of audio data which is
subsequently filtered (RC filter) to give an audio output.

I was hoping to create a driver that was suitably upstreamable and thought
about implementing within the world of the pwm class (and was coming here
to ask for guidance).  Basically I was thinking about implementing it in
as an extension of the pwm class:

Add parameter to config() to enable dma access, this will then create a
suitable /dev/pwm_dma0 etc. interface to write data to

Only issue is we have a number of parameters / modes we'd like to support
that are likely to be platform specific rather than general:

1) Ability to switch between three different modes:
	A) serial mode (where the output is actually just a serialisation of the
fifo data.)
	B) two formats of mark space ratio, giving a standard duty cycle or a
distributed mark space
2) Ability to set a 'silence value' i.e. what value you transmit when the
fifo runs dry

Whats your take on it?  In the end if not I'll implement a pwm_dma driver
as a platform device specific to the 2835 device

Thanks

Gordon


-- 
Director of Engineering, Raspberry Pi (Trading) Limited
T:	+44 (0) 1223 322633
M:	+44 (0) 7450 946289
E:	gordon@raspberrypi.org
W:	www.raspberrypi.org











