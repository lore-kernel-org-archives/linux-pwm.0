From: Ray Jui <ray.jui@broadcom.com>
Subject: Re: [PATCH INTERNAL V3 0/3] Add support for PWM Configure and
 stablize for PWM kona
Date: Fri, 11 Jan 2019 15:58:59 -0800
Message-ID: <4678b237-d0df-ef85-182f-759125a5c085@broadcom.com>
References: <1547183284-19956-1-git-send-email-sheetal.tigadoli@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1547183284-19956-1-git-send-email-sheetal.tigadoli@broadcom.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Please remove 'INTERNAL' in all of your patches and cover letter.

On 1/10/2019 9:08 PM, Sheetal Tigadoli wrote:
> Hi,
> 	This patchset contain support to make PWM changes configure
> 	and stablize
> 	Following are brief changes done
> 	a. Add support for version2 compatible string
> 	b. Change PWM config and stablize delay in PWM Kona
> 
> Praveen Kumar B (3):
>   dt-bindings: pwm: kona: Add new compatible for new version pwm-kona
>   drivers: pwm: pwm-bcm-kona: Add pwm-kona-v2 support
>   ARM: dts: cygnus: Change pwm compatible to new version
> 
>  .../devicetree/bindings/pwm/brcm,kona-pwm.txt      |   2 +-
>  arch/arm/boot/dts/bcm-cygnus.dtsi                  |   2 +-
>  drivers/pwm/pwm-bcm-kona.c                         | 128 ++++++++++++++++-----
>  3 files changed, 100 insertions(+), 32 deletions(-)
> 
