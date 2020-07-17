From: Scott Branden <scott.branden@broadcom.com>
Subject: Re: [PATCH v2] pwm: bcm-iproc: handle clk_get_rate() return
Date: Fri, 17 Jul 2020 16:11:40 -0700
Message-ID: <61a62404-6a44-53c3-6d17-89fa7a4c8551@broadcom.com>
References: <20200717182512.26001-1-scott.branden@broadcom.com>
 <20200717230431.4oj44cfnkhkd2o6z@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200717230431.4oj44cfnkhkd2o6z@pengutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
List-Id: linux-pwm@vger.kernel.org



On 2020-07-17 4:04 p.m., Uwe Kleine-König wrote:
> On Fri, Jul 17, 2020 at 11:25:12AM -0700, Scott Branden wrote:
>> From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
>>
>> Handle clk_get_rate() returning <= 0 condition to avoid
>> possible division by zero.
> You advertise handling <= 0, but in the code only == 0 is checked. One
> of the two is wrong ...
I checked - clk_get_rate can't return negative values.
I'll update the commit message from <= to ==.
>
> Best regards
> Uwe
>
Thanks,
  Scott
