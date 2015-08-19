From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v4 4/4] misc: atmel_tclib: get and use slow clock
Date: Wed, 19 Aug 2015 23:24:44 +0200
Message-ID: <55D4F41C.6010109@linaro.org>
References: <1439717026-30634-1-git-send-email-alexandre.belloni@free-electrons.com> <1439717026-30634-5-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:36142 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751700AbbHSVYq (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 19 Aug 2015 17:24:46 -0400
Received: by pawq9 with SMTP id q9so11324636paw.3
        for <linux-pwm@vger.kernel.org>; Wed, 19 Aug 2015 14:24:46 -0700 (PDT)
In-Reply-To: <1439717026-30634-5-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org

On 08/16/2015 11:23 AM, Alexandre Belloni wrote:
> From: Boris Brezillon <boris.brezillon@free-electrons.com>
>
> Commit dca1a4b5ff6e ("clk: at91: keep slow clk enabled to prevent sys=
tem
> hang") added a workaround for the slow clock as it is not properly ha=
ndled
> by its users.
>
> Get and use the slow clock as it is necessary for the timer counters.
>
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.co=
m>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
