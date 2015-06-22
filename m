From: Varka Bhadram <varkabhadram@gmail.com>
Subject: Re: [v2 4/7] mfd: intel_soc_pmic_core: ADD PWM lookup table for CRC
 PMIC based PWM
Date: Mon, 22 Jun 2015 16:33:22 +0530
Message-ID: <5587EB7A.5090402@gmail.com>
References: <1434970465-12687-1-git-send-email-shobhit.kumar@intel.com> <1434970465-12687-5-git-send-email-shobhit.kumar@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1434970465-12687-5-git-send-email-shobhit.kumar@intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Shobhit Kumar <shobhit.kumar@intel.com>, linux-pwm <linux-pwm@vger.kernel.org>, intel-gfx <intel-gfx@lists.freedesktop.org>, linux-kernel <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, linux-gpio <linux-gpio@vger.kernel.org>
Cc: Paul Bolle <pebolle@tiscali.nl>, Jani Nikula <jani.nikula@intel.com>, Samuel Ortiz <sameo@linux.intel.com>, Alexandre Courbot <gnurou@gmail.com>, David Airlie <airlied@linux.ie>, Povilas Staniulis <wdmonster@gmail.com>, Chih-Wei Huang <cwhuang@android-x86.org>, Thierry Reding <thierry.reding@gmail.com>, Daniel Vetter <daniel.vetter@intel.com>, Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Paul Gortmaker <paul.gortmaker@windriver.com>, bloften80@gmail.com
List-Id: linux-pwm@vger.kernel.org

Hi Shobhit Kumar,

On 06/22/2015 04:24 PM, Shobhit Kumar wrote:

> On some BYT PLatform the PWM is controlled using CRC PMIC. Add a lookup
> entry for the same to be used by the consumer (Intel GFX)
>
> v2: Remove the lookup table on driver unload (Thierry)
>
> v3: Correct the subject line (Lee jones)

This part should only describe what this is about..

Don't put this patch change history over here.
Include this change history after
...
Signed-off-by: Author <email>
---

> CC: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Alexandre Courbot <gnurou@gmail.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Shobhit Kumar <shobhit.kumar@intel.com>
> ---

Here you add this change history so that after applying this
will not be the part of your commit description.

This comment is applicable for all of your patches.


-- 
Best regards,
Varka Bhadram.

--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" in
