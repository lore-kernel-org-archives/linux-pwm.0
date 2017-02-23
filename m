From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH 2/2] drivers: pwm: pwm-atmel: add support to allow run
 time changing of pwm parameters
Date: Thu, 23 Feb 2017 11:32:39 +0100
Message-ID: <20170223103239.tv6nodddlar5l5fl@piout.net>
References: <1487839120-13650-1-git-send-email-claudiu.beznea@microchip.com>
 <1487839120-13650-3-git-send-email-claudiu.beznea@microchip.com>
 <20170223092148.5qmxy62xkufwbsrw@piout.net>
 <f963def2-6d82-3bf7-22fa-8915f408ca54@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:39372 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750916AbdBWKcq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 23 Feb 2017 05:32:46 -0500
Content-Disposition: inline
In-Reply-To: <f963def2-6d82-3bf7-22fa-8915f408ca54@microchip.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: m18063 <Claudiu.Beznea@microchip.com>
Cc: thierry.reding@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, boris.brezillon@free-electrons.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 23/02/2017 at 12:25:58 +0200, m18063 wrote:
> > It is probably worth switching to atomic PWM instead of changing this
> > function. This would simplify the whole driver.
> I was thinking to switch to atomic PWM in a future patch.

Then why wait ?


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
