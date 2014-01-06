From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH] ARM: pxa: Add dummy backlight power supply on Mitac Mio A701
Date: Mon, 06 Jan 2014 09:19:22 +0100
Message-ID: <87zjn9v7xx.fsf@free.fr>
References: <1387532812-11742-1-git-send-email-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from smtp6-g21.free.fr ([212.27.42.6]:54302 "EHLO smtp6-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752916AbaAFITf (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Mon, 6 Jan 2014 03:19:35 -0500
In-Reply-To: <1387532812-11742-1-git-send-email-thierry.reding@gmail.com>
	(Thierry Reding's message of "Fri, 20 Dec 2013 10:46:52 +0100")
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org

Thierry Reding <thierry.reding@gmail.com> writes:

> Recent changes to the pwm-backlight driver have made the power supply
> mandatory. There is code in the regulator core to deal with situations
> where no regulator is specified and provide a dummy, but that works on
> DT-based boards only.
>
> The situation can be remedied by adding a dummy regulator during board
> initialization.

Haojian, ping ?
We're at -rc7 and I've seen no pull of this fix. As the display is broken
without it, I'd really like to have it fixed for v3.13.

Cheers.

--
Robert
