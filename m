From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v7 01/24] mfd: Add ingenic-tcu.h header
Date: Mon, 10 Sep 2018 15:58:02 +0100
Message-ID: <20180910145802.GV28860@dell>
References: <20180821171635.22740-1-paul@crapouillou.net>
 <20180821171635.22740-2-paul@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180821171635.22740-2-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Cercueil <paul@crapouillou.net>
Cc: Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Jonathan Corbet <corbet@lwn.net>, od@zcrc.me, Mathieu Malaterre <malat@debian.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-mips@linux-mips.org, linux-doc@vger.kernel.org, linux-clk@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Tue, 21 Aug 2018, Paul Cercueil wrote:

> This header contains macros for the registers that are present in the
> regmap shared by all the drivers related to the TCU (Timer Counter Unit)
> of the Ingenic JZ47xx SoCs.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> ---
> 
> Notes:
>      v2: Use SPDX identifier for the license
>     
>      v3: - Use macros instead of enum
>          - Add 'TCU_' at the beginning of each macro
>     	 - Remove useless include <linux/regmap.h>
>     
>      v4: No change
>     
>      v5: No change
>     
>      v6: Rename barrier macro from __LINUX_CLK_INGENIC_TCU_H__ to
>          __LINUX_MFD_INGENIC_TCU_H__
>     
>      v7: No change
> 
>  include/linux/mfd/ingenic-tcu.h | 56 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 include/linux/mfd/ingenic-tcu.h

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
