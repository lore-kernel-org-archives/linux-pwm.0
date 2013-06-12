Return-Path: <sachin.kamat@linaro.org>
MIME-Version: 1.0
In-Reply-To: <1371036553-32263-1-git-send-email-thierry.reding@gmail.com>
References: <1371036553-32263-1-git-send-email-thierry.reding@gmail.com>
Date: Wed, 12 Jun 2013 17:05:18 +0530
Message-ID: <CAK9yfHyUT7KUkY3g2WJ7XiisLL5mvJuenv=UEK_9OqwfF7s4Zg@mail.gmail.com>
Subject: Re: [PATCH] pwm: Fill in missing .owner fields
From: Sachin Kamat <sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-pwm.vger.kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Thierry,

On 12 June 2013 16:59, Thierry Reding <thierry.reding@gmail.com> wrote:
> Some drivers don't set the .owner fields of the struct device_driver or
> struct pwm_ops, which causes the module usage count to become wrong.


Recently a patch [1] was added to solve this issue of missing .owner
fileds in struct platform_driver.
Probably something similar could be done for struct pwm_ops too?


[1] https://patchwork.kernel.org/patch/2612961/

-- 
With warm regards,
Sachin
