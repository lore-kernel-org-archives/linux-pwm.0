From: Gordon Hollingworth <gordon@raspberrypi.org>
Subject: Re: PWM DMA interface
Date: Wed, 18 Jun 2014 08:20:58 +0000
Message-ID: <61114322-BF2B-4E67-B4B9-30E20D7D60CD@raspberrypi.org>
References: <CFBB4FD9.4313A%gordon@raspberrypi.org>,<20140617225401.GA25525@mithrandir>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail1.bemta3.messagelabs.com ([195.245.230.177]:12321 "EHLO
	mail1.bemta3.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964953AbaFRI2M convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Wed, 18 Jun 2014 04:28:12 -0400
In-Reply-To: <20140617225401.GA25525@mithrandir>
Content-Language: en-GB
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>

Yes within the limitations of the simple RC filter but basically it's working like a one bit DAC

Gordon


> On 17 Jun 2014, at 23:54, "Thierry Reding" <thierry.reding@gmail.com> wrote:
> 
>> On Mon, Jun 09, 2014 at 10:49:46AM +0000, Gordon Hollingworth wrote:
>> Hi,
>> 
>> I've been writing a driver that uses the PWM to talk to devices that
>> communicate through a pwm like signal.  To achieve this some devices have
>> a dma interface that you can stream data at to the pwm...
>> 
>> We use something similar to this on Raspberry Pi to do audio output, we
>> use the PWM interface to output a 'stream' of audio data which is
>> subsequently filtered (RC filter) to give an audio output.
> 
> What kind of audio data is this? Is it able to play back any arbitrary
> audio signal?
> 
> Thierry
