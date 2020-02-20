From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH] pwm: bcm2835: Dynamically allocate base
Date: Thu, 20 Feb 2020 11:14:00 -0800
Message-ID: <3b22decc-9ebd-3522-4fd7-e5721c8b25b2@gmail.com>
References: <20200203213536.32226-1-f.fainelli@gmail.com>
 <08e2b640f0a7713d905295fc4f75df49617be6c1.camel@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38685 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728111AbgBTTOS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 20 Feb 2020 14:14:18 -0500
In-Reply-To: <08e2b640f0a7713d905295fc4f75df49617be6c1.camel@suse.de>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, Florian Fainelli <f.fainelli@gmail.com>, linux-kernel@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>
Cc: "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>, Bart Tanghe <bart.tanghe@thomasmore.be>, Scott Branden <sbranden@broadcom.com>, Stephen Warren <swarren@wwwdotorg.org>, Ray Jui <rjui@broadcom.com>, "maintainer:BROADCOM BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE..." <bcm-kernel-feedback-list@broadcom.com>, "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>, =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>

On 2/4/20 1:17 AM, Nicolas Saenz Julienne wrote:
> On Mon, 2020-02-03 at 13:35 -0800, Florian Fainelli wrote:
>> The newer 2711 and 7211 chips have two PWM controllers and failure to
>> dynamically allocate the PWM base would prevent the second PWM
>> controller instance being probed for succeeding with an -EEXIST error
>> from alloc_pwms().
>>
>> Fixes: e5a06dc5ac1f ("pwm: Add BCM2835 PWM driver")
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
> 
> Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Thierry, is there any chance we can get this applied for an upcoming
5.6-rcX? Thank you!
-- 
Florian
