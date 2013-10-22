Return-Path: <Voice.Shen@atmel.com>
Message-ID: <52664FB6.4000004@atmel.com>
Date: Tue, 22 Oct 2013 18:13:10 +0800
From: Bo Shen <voice.shen@atmel.com>
MIME-Version: 1.0
Subject: Re: [PATCH v5] PWM: atmel-pwm: add PWM controller driver
References: <1380532240-18650-1-git-send-email-voice.shen@atmel.com> <20131008131727.GB12839@ulmo.nvidia.com>
In-Reply-To: <20131008131727.GB12839@ulmo.nvidia.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: voice.shen@atmel.com
List-ID: <linux-pwm.vger.kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: plagnioj@jcrosoft.com, nicolas.ferre@atmel.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, alexandre.belloni@free-electrons.com

Hi All,

On 10/8/2013 21:17, Thierry Reding wrote:
> On Mon, Sep 30, 2013 at 05:10:40PM +0800, Bo Shen wrote:
>> Add Atmel PWM controller driver based on PWM framework.
>>
>> This is the basic function implementation of Atmel PWM controller.
>> It can work with PWM based led and backlight.
>>
>> Signed-off-by: Bo Shen <voice.shen@atmel.com>
>>
>> ---
>> Changes in v5:
>>    - call clk_disable directly, if so, it won't cause more than one channel
>>      enabled, the clock can not be disabled.
>>
>> Changes in v4:
>>    - check the return value of clk_prepare()
>>    - change channel register size as constant
>>
>> Changes in v3:
>>    - change compatible string from "atmel,sama5-pwm" to "atmel,sama5d3-pwm"
>>    - Add PWM led example in binding documentation
>>    - Using micro replace hard code
>>
>> Changes in v2:
>>    - Address the comments from Thierry Reding
>>
>>   .../devicetree/bindings/pwm/atmel-pwm.txt          |   41 +++
>>   drivers/pwm/Kconfig                                |    9 +
>>   drivers/pwm/Makefile                               |    1 +
>>   drivers/pwm/pwm-atmel.c                            |  344 ++++++++++++++++++++
>>   4 files changed, 395 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/pwm/atmel-pwm.txt
>>   create mode 100644 drivers/pwm/pwm-atmel.c
>
> I haven't seen an Acked-by from the device tree bindings maintainers on
> this. I've Cc'ed them, so hopefully one of them has time to review.

Any comments?

Best Regards,
Bo Shen
