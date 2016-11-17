From: Jian Yuan <yuanjian12@hisilicon.com>
Subject: Re: [PATCH v5] pwm: add pwm driver for HiSilicon BVT SOCs
Date: Thu, 17 Nov 2016 10:32:38 +0800
Message-ID: <d9cbc20c-d1c8-ca7b-953f-035013cf758e@hisilicon.com>
References: <1479289833-232200-1-git-send-email-yuanjian12@hisilicon.com>
 <664f5d9b-ebf4-d511-8e59-2f57c00ea901@mleia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:60978 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752377AbcKQCdU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 16 Nov 2016 21:33:20 -0500
In-Reply-To: <664f5d9b-ebf4-d511-8e59-2f57c00ea901@mleia.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Vladimir Zapolskiy <vz@mleia.com>, thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, xuejiancheng@hisilicon.com, kevin.lixu@hisilicon.com, jalen.hsu@hisilicon.com



On 2016/11/17 7:55, Vladimir Zapolskiy wrote:
> On 11/16/2016 11:50 AM, Jian Yuan wrote:
>> From: yuanjian <yuanjian12@hisilicon.com>
>>
>> Add PWM driver for the PWM controller found on HiSilicon BVT SOCs, like Hi3519V100, Hi3516CV300, etc.
>> The PWM controller is primarily in charge of controlling P-Iris lens.
>>
>> Reviewed-by: Jiancheng Xue <xuejiancheng@hisilicon.com>
>> Signed-off-by: Jian Yuan <yuanjian12@hisilicon.com>
>> ---
>> Change Log:
>> v5:
>> remove the generic compatible string "hisilicon, hibvt-pwm".
>> v4:
>> Add #pwm-cells in the bindings document.
>> v3:
>> fixed issues pointed by thierry.
>> Add PWM compatible string for Hi3519V100.
>> Implement .apply() function which support atomic, instead of .enable()/.disable()/.config().
>> v2:
>> The number of PWMs is change to be probeable based on the compatible string.
>>
>>  .../devicetree/bindings/pwm/pwm-hibvt.txt          |  22 ++
>>  drivers/pwm/Kconfig                                |   9 +
>>  drivers/pwm/Makefile                               |   1 +
>>  drivers/pwm/pwm-hibvt.c                            | 269 +++++++++++++++++++++
>>  4 files changed, 301 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-hibvt.txt
>>  create mode 100644 drivers/pwm/pwm-hibvt.c
>>
>> diff --git a/Documentation/devicetree/bindings/pwm/pwm-hibvt.txt b/Documentation/devicetree/bindings/pwm/pwm-hibvt.txt
>> new file mode 100644
>> index 0000000..fe63950
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pwm/pwm-hibvt.txt
>> @@ -0,0 +1,22 @@
>> +Hisilicon PWM controller
>> +
>> +Required properties:
>> +-compatible: should contain one SoC specific compatible string
>> + The SoC specific strings supported including:
>> +    "hisilicon,hi3516cv300-pwm"
>> +    "hisilicon,hi3519v100-pwm"
>> +- reg: physical base address and length of the controller's registers.
>> +- clocks: phandle and clock specifier of the PWM reference clock.
>> +- resets: phandle and reset specifier for the PWM controller reset.
>> +- #pwm-cells: Should be 2. See pwm.txt in this directory for a description of
> 
> Since the controller has separate polarity control register, and
> the driver handles polarity settings, please test/change #pwm-cells
> set to 3. It is better to do it right now before someone wants
> to change number of cells in future and support polarity specified
> in DTB.
> 
Goog advice. I would add it in next patch v6.
>> +  the cells format.
>> +
>> +Example:
>> +    pwm: pwm@12130000 {
>> +
> 
> Remove empty line above.
> 
Ok.
>> +        compatible = "hisilicon,hi3516cv300-pwm";
>> +        reg = <0x12130000 0x10000>;
>> +        clocks = <&crg_ctrl HI3516CV300_PWM_CLK>;
>> +        resets = <&crg_ctrl 0x38 0>;
>> +        #pwm-cells = <2>;
> 
> After tesing #pwm-cells = <3> don't forget to updated this line.
> 
Got it.
Thanks,
Jian Yuan
>> +    };
> 
> -- 
> With best wishes,
> Vladimir
> 
> .
> 
