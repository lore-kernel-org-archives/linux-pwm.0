From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2 3/8] arm64: dts: exynos: Remove generic
 arm,armv8-pmuv3 compatible
Date: Fri, 3 Jul 2020 20:01:17 +0200
Message-ID: <20200703180117.GA1241@kozik-lap>
References: <20200702155149.12854-1-krzk@kernel.org>
 <20200702155149.12854-3-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ej1-f67.google.com ([209.85.218.67]:39845 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbgGCSBX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Jul 2020 14:01:23 -0400
Content-Disposition: inline
In-Reply-To: <20200702155149.12854-3-krzk@kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Sylwester Nawrocki <snawrocki@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Pankaj Dubey <pankaj.dubey@samsung.com>

On Thu, Jul 02, 2020 at 05:51:44PM +0200, Krzysztof Kozlowski wrote:
> The ARM PMU node is described enough with first compatible so remove the
> arm,armv8-pmuv3 to fix dtschema warnings like:
> 
>     arm-pmu: compatible: Additional items are not allowed ('arm,armv8-pmuv3' was unexpected)
>     arm-pmu: compatible: ['arm,cortex-a57-pmu', 'arm,armv8-pmuv3'] is too long
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v1:
> 1. None
> 
> Not tested although no effect expected.
> ---
>  arch/arm64/boot/dts/exynos/exynos5433.dtsi | 4 ++--
>  arch/arm64/boot/dts/exynos/exynos7.dtsi    | 2 +-

Applied.

Best regards,
Krzysztof
