From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5] pwm: add pwm driver for HiSilicon BVT SOCs
Date: Fri, 18 Nov 2016 08:10:15 -0600
Message-ID: <20161118141015.xsqrcg5xpwhmj7c5@rob-hp-laptop>
References: <1479289833-232200-1-git-send-email-yuanjian12@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1479289833-232200-1-git-send-email-yuanjian12@hisilicon.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jian Yuan <yuanjian12@hisilicon.com>
Cc: thierry.reding@gmail.com, mark.rutland@arm.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, xuejiancheng@hisilicon.com, kevin.lixu@hisilicon.com, jalen.hsu@hisilicon.com
List-Id: linux-pwm@vger.kernel.org

On Wed, Nov 16, 2016 at 05:50:33PM +0800, Jian Yuan wrote:
> From: yuanjian <yuanjian12@hisilicon.com>
> 
> Add PWM driver for the PWM controller found on HiSilicon BVT SOCs, like Hi3519V100, Hi3516CV300, etc.
> The PWM controller is primarily in charge of controlling P-Iris lens.
> 
> Reviewed-by: Jiancheng Xue <xuejiancheng@hisilicon.com>
> Signed-off-by: Jian Yuan <yuanjian12@hisilicon.com>
> ---
> Change Log:
> v5:
> remove the generic compatible string "hisilicon, hibvt-pwm".
> v4:
> Add #pwm-cells in the bindings document.
> v3:
> fixed issues pointed by thierry.
> Add PWM compatible string for Hi3519V100.
> Implement .apply() function which support atomic, instead of .enable()/.disable()/.config().
> v2:
> The number of PWMs is change to be probeable based on the compatible string.
> 
>  .../devicetree/bindings/pwm/pwm-hibvt.txt          |  22 ++

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/pwm/Kconfig                                |   9 +
>  drivers/pwm/Makefile                               |   1 +
>  drivers/pwm/pwm-hibvt.c                            | 269 +++++++++++++++++++++
>  4 files changed, 301 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-hibvt.txt
>  create mode 100644 drivers/pwm/pwm-hibvt.c
