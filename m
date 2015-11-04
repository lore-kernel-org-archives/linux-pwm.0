From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH] pwm: brcmstb: Don't set can_sleep flag
Date: Tue, 3 Nov 2015 17:08:03 -0800
Message-ID: <20151104010803.GK7274@google.com>
References: <1446545320.6627.0.camel@ingics.com>
 <20151104003153.GJ7274@google.com>
 <56395630.1030405@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35519 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755568AbbKDBIG (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 3 Nov 2015 20:08:06 -0500
Received: by pasz6 with SMTP id z6so35112125pas.2
        for <linux-pwm@vger.kernel.org>; Tue, 03 Nov 2015 17:08:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <56395630.1030405@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Axel Lin <axel.lin@ingics.com>, Thierry Reding <thierry.reding@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, linux-pwm@vger.kernel.org

On Tue, Nov 03, 2015 at 04:49:52PM -0800, Florian Fainelli wrote:
> Now, I do agree that the terminology is a little confusing here. If you
> look at the GPIO API there are gpio_*_cansleep() accessors, which in
> their case, convey the correct meaning: the operation can/might sleep.

Perhaps I'm misreading, but that actually sounds exactly the same as the
pwm_can_sleep() API. It sounds OK from a consumer/API perspective, but I
was just commenting on the perspective of the driver writer.

Maybe it's not worth much change, then, if several subsystems have
similar naming.

Brian
