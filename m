From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH v4 0/2] pwm: Broadcom BCM7038 PWM controller (v4)
Date: Fri, 25 Sep 2015 16:05:05 -0700
Message-ID: <5605D321.6000207@gmail.com>
References: <1442274426-3507-1-git-send-email-f.fainelli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442274426-3507-1-git-send-email-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>, linux-kernel@vger.kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com, thierry.reding@gmail.com, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, ariel@vanguardiasur.com.ar
List-Id: linux-pwm@vger.kernel.org

On 14/09/15 16:47, Florian Fainelli wrote:
> Hi,
> 
> This patch series add PWM support for the Broadcom BCM7xxx
> chips which feature one or more PWM controllers capable of
> output periods from 148ns to ~622ms using a combination of
> variable and fixed frequency settings.

Thierry, are you happy with this version of the patches? Thanks.

> 
> The controller does not support setting a polarity.
> 
> This is based on Thierry's pwm/next branch.
> 
> Florian Fainelli (2):
>   Documentation: dt: add Broadcom BCM7038 PWM controller binding
>   pwm: Add Broadcom BCM7038 PWM controller support
> 
>  .../devicetree/bindings/pwm/brcm,bcm7038-pwm.txt   |  20 ++
>  drivers/pwm/Kconfig                                |  10 +
>  drivers/pwm/Makefile                               |   1 +
>  drivers/pwm/pwm-brcmstb.c                          | 345 +++++++++++++++++++++
>  4 files changed, 376 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/brcm,bcm7038-pwm.txt
>  create mode 100644 drivers/pwm/pwm-brcmstb.c
> 


-- 
Florian
