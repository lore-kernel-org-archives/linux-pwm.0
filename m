From: Gordon Hollingworth <gordon@raspberrypi.org>
Subject: Re: PWM DMA interface
Date: Thu, 19 Jun 2014 15:12:03 +0000
Message-ID: <CFC8BBA1.43AEA%gordon@raspberrypi.org>
References: <20140618221200.GE26514@mithrandir>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail1.bemta3.messagelabs.com ([195.245.230.176]:11941 "EHLO
	mail1.bemta3.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932502AbaFSPMN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Thu, 19 Jun 2014 11:12:13 -0400
In-Reply-To: <20140618221200.GE26514@mithrandir>
Content-Language: en-US
Content-ID: <4073DBB3B105FB4FBF37EC8E5A70C7B4@hs20.net>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>

On 18/06/2014 23:12, "Thierry Reding" <thierry.reding@gmail.com> wrote:


>On Wed, Jun 18, 2014 at 08:20:58AM +0000, Gordon Hollingworth wrote:
>> Yes within the limitations of the simple RC filter but basically it's
>> working like a one bit DAC
>
>Perhaps a better way to expose this, then, would be as a proper sound
>device so that the standard ALSA tools can be used to play back audio
>rather than needing a set of custom tools.
>
>Thierry

Yes, although it would be better to expose the PWM DMA interface through a
PWM class and then implement an ALSA driver on top of this rather than
just hacking in a Pi specific pwm driver...

Mostly because I want to write a different driver that uses the PWM DMA
interface on the Pi but it seems wrong to do this without having a common
PWM_DMA interface


Gordon

