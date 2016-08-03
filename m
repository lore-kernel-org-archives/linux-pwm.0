From: Jian Yuan <yuanjian12@hisilicon.com>
Subject: Re: [PATCH] pwm: add pwm driver for HiSilicon BVT SOCs
Date: Wed, 3 Aug 2016 14:32:52 +0800
Message-ID: <3fc992b7-c141-8da4-52c9-00c65ad4da42@hisilicon.com>
References: <1470015728-36979-1-git-send-email-yuanjian12@hisilicon.com>
 <20160801124355.GB13179@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:18219 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752721AbcHCGeY (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 3 Aug 2016 02:34:24 -0400
In-Reply-To: <20160801124355.GB13179@leverpostej>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: thierry.reding@gmail.com, robh+dt@kernel.org, xuejiancheng@hisilicon.com, kevin.lixu@hisilicon.com, jalen.hsu@hisilicon.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org



On 2016/8/1 20:43, Mark Rutland wrote:
> On Mon, Aug 01, 2016 at 09:42:08AM +0800, Jian Yuan wrote:
>> From: yuanjian <yuanjian12@hisilicon.com>
>>
>> Add pwm driver for HiSilicon BVT SOCs
>>
>> Reviewed-by: Jiancheng Xue <xuejiancheng@hisilicon.com>
>> Signed-off-by: Jian Yuan <yuanjian12@hisilicon.com>
>> ---
>>  .../devicetree/bindings/pwm/pwm-hibvt.txt          |  18 ++
>>  drivers/pwm/Kconfig                                |  10 +
>>  drivers/pwm/Makefile                               |   1 +
>>  drivers/pwm/pwm-hibvt.c                            | 272 +++++++++++++++++++++
>>  4 files changed, 301 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-hibvt.txt
>>  create mode 100644 drivers/pwm/pwm-hibvt.c
>>
>> diff --git a/Documentation/devicetree/bindings/pwm/pwm-hibvt.txt b/Documentation/devicetree/bindings/pwm/pwm-hibvt.txt
>> new file mode 100644
>> index 0000000..4efd83e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pwm/pwm-hibvt.txt
>> @@ -0,0 +1,18 @@
>> +Hisilicon PWM controller
>> +
>> +Required properties:
>> + - compatible: should be "hisilicon,hibvt-pwm" and one of the following:
>> +			"hisilicon,hi3516cv300-pwm".
> 
> I take it "hisilicon,hibvt-pwm" is the fallback entry.
> 
> It would be good to note that explicitly.
> 
I do not understand what the fallback entry means.

"hisilicon,hibvt-pwm" is a general compatible string, which is available for most HiSilicon BVT SOCs.
Howerver, "hisilicon,hi3516cv300-pwm" is specially for hi3516cv300.

Maybe I should note the compatible string as described above, right?

>> + - reg: physical base address and length of the controller's registers.
>> + - clocks: phandle and clock specifier of the PWM reference clock.
>> + - resets: offset address and offset bit for reset or unreset of the controller.
>> + - pwm-nums: pwm number of the controller.
> 
> This should be 'num-pwms'.
> 
> I assume this is the number of PWMs exposed by this controller. Is this
> not probeable, or dicoverable based on the compatible string?
> 
> How does this vary in practice?
> 
"pwm-nums" means the maximum number of PWMS that this controller can support, which is the hardware capability.
E.g.,HI3516CV300 PWM controller supports 4 PWM, while other chips support 8 PWM.

I agree that the PWM number is probeable based on the compatible string. I shall change it, thanks.

>> +
>> +Example:
>> +	pwm: pwm@12130000 {
>> +		compatible = "hisilicon,hibvt-pwm";
> 
> This is missing "hisilicon,hi3516cv300-pwm" as per the requirements of
> the binding.
> 
Ok, it's right. I'll fix it in next v2 patch.

>> +		reg = <0x12130000 0x10000>;
>> +		clocks = <&crg_ctrl HI3516CV300_PWM_CLK>;
>> +		resets = <&crg_ctrl 0x38 0>;
>> +		pwm-nums = <4>;
>> +	};
> 
> Thanks,
> Mark.
> 
> .
> 
Thanks,
Jian.
