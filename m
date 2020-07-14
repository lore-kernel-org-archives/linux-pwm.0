From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/8] dt-bindings: pwm: samsung: Do not require
 interrupts on Exynos SoCs
Date: Mon, 13 Jul 2020 20:46:52 -0600
Message-ID: <20200714024652.GA1184042@bogus>
References: <20200702155149.12854-1-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-io1-f67.google.com ([209.85.166.67]:40079 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbgGNCqz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 13 Jul 2020 22:46:55 -0400
Content-Disposition: inline
In-Reply-To: <20200702155149.12854-1-krzk@kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh+dt@kernel.org>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Pankaj Dubey <pankaj.dubey@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, devicetree@vger.kernel.org, Sylwester Nawrocki <snawrocki@kernel.org>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, 02 Jul 2020 17:51:42 +0200, Krzysztof Kozlowski wrote:
> The bindings required interrupts for all SoCs but actually only the PWM
> timer clocksource (for S3C/S5P SoCs) was using them.  This PWM timer
> clocksource driver is not used on Exynos SoCs thus the interrupts can be
> marked as optional.
> 
> Reported-by: Alim Akhtar <alim.akhtar@samsung.com>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v1:
> 1. New patch
> ---
>  .../devicetree/bindings/pwm/pwm-samsung.yaml  | 23 +++++++++++++++----
>  1 file changed, 18 insertions(+), 5 deletions(-)
> 

Applied, thanks!
