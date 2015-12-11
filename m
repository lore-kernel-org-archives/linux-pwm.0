From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH] backlight: pwm_bl: Fix broken PWM backlight for non-dt platforms
Date: Fri, 11 Dec 2015 18:33:22 +0100
Message-ID: <87r3isj3fh.fsf@belgarion.home>
References: <1449738546-10279-1-git-send-email-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:18416 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752093AbbLKRd3 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 11 Dec 2015 12:33:29 -0500
In-Reply-To: <1449738546-10279-1-git-send-email-p.zabel@pengutronix.de>
	(Philipp Zabel's message of "Thu, 10 Dec 2015 10:09:06 +0100")
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, kernel@pengutronix.de, linux-kernel@vger.kernel.org

Philipp Zabel <p.zabel@pengutronix.de> writes:

> Commit ee65ad0e2a9e ("backlight: pwm_bl: Avoid backlight flicker when
> probed from DT") tries to dereference the device of_node pointer
> unconditionally, causing a NULL pointer dereference on non-dt platforms.
> Fix it by replacing the phandle variable with a node variable and
> by checking that for NULL before dereferencing it.
>
> Reported-by: Robert Jarzmik <robert.jarzmik@free.fr>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
And indeed it does the trick.

Tested-by: Robert Jarzmik <robert.jarzmik@free.fr>

-- 
Robert
