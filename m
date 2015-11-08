From: Vladimir Zapolskiy <vz@mleia.com>
Subject: Re: [PATCH 0/4] pwm: lpc32xx: fixes in the LPC32xx PWM driver
Date: Sun, 08 Nov 2015 08:48:51 +0200
Message-ID: <563EF053.8060305@mleia.com>
References: <1444695653-23491-1-git-send-email-vz@mleia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mleia.com ([178.79.152.223]:43294 "EHLO mail.mleia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751219AbbKHGs4 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Sun, 8 Nov 2015 01:48:56 -0500
In-Reply-To: <1444695653-23491-1-git-send-email-vz@mleia.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Alexandre Pereira da Silva <aletes.xgr@gmail.com>, linux-pwm@vger.kernel.org

On 13.10.2015 03:20, Vladimir Zapolskiy wrote:
> The changeset fixes a number of issues within current implementation
> of LPC32xx PWM controller driver, namely
> - the SoC has two independent PWM controllers with one channel each,
> - runtime warnings from common clock framework,
> - overflow in duty cycle calculation may result in disabled PWM,
> - unsupported period values are silently accepted.
> 
> Vladimir Zapolskiy (4):
>   pwm: lpc32xx: correct number of PWM channels from 2 to 1
>   pwm: lpc32xx: fix warnings from common clock framework
>   pwm: lpc32xx: fix and simplify duty cycle and period calculations
>   pwm: lpc32xx: return ERANGE, if requested period is not supported
> 
>  drivers/pwm/pwm-lpc32xx.c | 59 ++++++++++++++++++-----------------------------
>  1 file changed, 22 insertions(+), 37 deletions(-)
> 

Hi Thierry,

are you going to pick these changes up to PWM branch?

Thanks in advance.

--
Vladimir
