From: Sylvain Lemieux <slemieux.tyco@gmail.com>
Subject: Re: [PATCH 3/3] pwm: lpc32xx: remove handling of PWM channels
Date: Wed, 07 Dec 2016 12:58:16 -0500
Message-ID: <1481133496.9248.3.camel@localhost>
References: <20161205014237.1689-1-vz@mleia.com>
         <20161205014308.1741-2-vz@mleia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:33515 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752850AbcLGR6S (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 7 Dec 2016 12:58:18 -0500
Received: by mail-io0-f195.google.com with SMTP id j92so15320413ioi.0
        for <linux-pwm@vger.kernel.org>; Wed, 07 Dec 2016 09:58:18 -0800 (PST)
In-Reply-To: <20161205014308.1741-2-vz@mleia.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, 2016-12-05 at 03:43 +0200, Vladimir Zapolskiy wrote:
> Because LPC32xx PWM controllers have single output which is registered as
> the only PWM device/channel per controller, it is known in advance that
> pwm->hwpwm value is always 0. On basis of this fact simplify the code
> by removing operations with pwm->hwpwm, there is no controls which require
> channel number as input.
> 
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> ---
>  drivers/pwm/pwm-lpc32xx.c | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
> 
Reviewed-by: Sylvain Lemieux <slemieux.tyco@gmail.com>
