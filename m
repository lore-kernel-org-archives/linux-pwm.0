From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH 2/3] pwm: bcm2835: prevent division by zero
Date: Wed, 2 Dec 2015 18:08:45 +0100
Message-ID: <565F259D.6060905@i2se.com>
References: <1449010541-3767-1-git-send-email-stefan.wahren@i2se.com>
 <1449010541-3767-3-git-send-email-stefan.wahren@i2se.com>
 <87h9k1yd2z.fsf@eliezer.anholt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:52144 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933362AbbLBRJW (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 2 Dec 2015 12:09:22 -0500
In-Reply-To: <87h9k1yd2z.fsf@eliezer.anholt.net>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Eric Anholt <eric@anholt.net>, Thierry Reding <thierry.reding@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>
Cc: Remi Pommarel <repk@triplefau.lt>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org

Am 02.12.2015 um 00:16 schrieb Eric Anholt:
> Stefan Wahren <stefan.wahren@i2se.com> writes:
>
>> It's possible that the pwm clock become an orphan. So better
>> check the result of clk_get_rate in order to prevent a division
>> by zero.
> How would we lose our clock when we're keeping the clock enabled from
> driver probe until remove?

It's not the problem that we lose the clock inside this driver. The pwm
clock could be initial assigned to a unregistered parent clock like "GND".

I'm refering to this discussion:

http://lists.infradead.org/pipermail/linux-rpi-kernel/2015-November/002603.html

>
> Patches 1 and 3 are:
>
> Reviewed-by: Eric Anholt <eric@anholt.net>
