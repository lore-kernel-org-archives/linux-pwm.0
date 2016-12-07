From: Sylvain Lemieux <slemieux.tyco@gmail.com>
Subject: Re: [PATCH 2/3] pwm: lpc32xx: switch driver to one phandle
 argument for PWM consumers
Date: Wed, 07 Dec 2016 12:57:31 -0500
Message-ID: <1481133451.9248.2.camel@localhost>
References: <20161205014237.1689-1-vz@mleia.com>
         <20161205014308.1741-1-vz@mleia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:35682 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752017AbcLGR5f (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 7 Dec 2016 12:57:35 -0500
Received: by mail-io0-f195.google.com with SMTP id h133so29793640ioe.2
        for <linux-pwm@vger.kernel.org>; Wed, 07 Dec 2016 09:57:35 -0800 (PST)
In-Reply-To: <20161205014308.1741-1-vz@mleia.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, 2016-12-05 at 03:43 +0200, Vladimir Zapolskiy wrote:
> NXP LPC32xx SoCs have two simple independent PWM controllers with a single
> output each, in this case there is no need to specify PWM channel argument
> on client side, one cell for setting PWM output frequency is sufficient.
> 
> The change adds private of_xlate() handling of a single cell value given
> with a PWM phandle on client side, the handling is taken from the PXA PWM
> driver.
> 
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> ---
>  drivers/pwm/pwm-lpc32xx.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
Reviewed-by: Sylvain Lemieux <slemieux.tyco@gmail.com>
