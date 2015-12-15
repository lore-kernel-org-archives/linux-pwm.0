From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH 0/3] pwm: bcm2835: improve clock handling
Date: Tue, 15 Dec 2015 18:59:31 +0100 (CET)
Message-ID: <2004478620.33734.6de503e6-02cb-4cce-af2d-c2614efc234a.open-xchange@email.1und1.de>
References: <1449010541-3767-1-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.134]:52836 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753528AbbLOSAK (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 15 Dec 2015 13:00:10 -0500
In-Reply-To: <1449010541-3767-1-git-send-email-stefan.wahren@i2se.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>, Thierry Reding <thierry.reding@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>
Cc: linux-pwm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Remi Pommarel <repk@triplefau.lt>


> Stefan Wahren <stefan.wahren@i2se.com> hat am 1. Dezember 2015 um 23:55
> geschrieben:
>
>
> With the upcoming PWM clock support the pwm-bcm2835 should take
> more care about the clock handling. But this patch series doesn't
> depend on these clock driver changes.
>
> Stefan Wahren (3):
> pwm: bcm2835: calculate scaler in pwm_config
> pwm: bcm2835: prevent division by zero
> pwm: bcm2835: fix email address specifiction
>
> drivers/pwm/pwm-bcm2835.c | 18 ++++++++++++------
> 1 file changed, 12 insertions(+), 6 deletions(-)
>

gently ping
