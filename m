From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/3] pwm: add DT bindings for the STMPE PWM
Date: Fri, 12 Feb 2016 09:24:54 -0600
Message-ID: <20160212152454.GA31285@rob-hp-laptop>
References: <1455094468-25521-1-git-send-email-linus.walleij@linaro.org>
 <1455094468-25521-2-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:42846 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750968AbcBLPY6 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Fri, 12 Feb 2016 10:24:58 -0500
Content-Disposition: inline
In-Reply-To: <1455094468-25521-2-git-send-email-linus.walleij@linaro.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org

On Wed, Feb 10, 2016 at 09:54:26AM +0100, Linus Walleij wrote:
> This adds fairly standard device tree bindings for the STMPE
> PWM found in STMPE24xx multi-purpose expanders.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  Documentation/devicetree/bindings/pwm/st,stmpe-pwm.txt | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/st,stmpe-pwm.txt

Acked-by: Rob Herring <robh@kernel.org>
