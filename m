From: Jian Yuan <yuanjian12@hisilicon.com>
Subject: Re: [RESEND PATCH v4] pwm: add pwm driver for HiSilicon BVT SOCs
Date: Thu, 17 Nov 2016 09:28:46 +0800
Message-ID: <a1348414-4e59-d8ac-6ea9-84f12d3fe7d7@hisilicon.com>
References: <1479213692-223477-1-git-send-email-yuanjian12@hisilicon.com>
 <20161116134800.ogkvz7zxc35woodd@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161116134800.ogkvz7zxc35woodd@rob-hp-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: thierry.reding@gmail.com, mark.rutland@arm.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, xuejiancheng@hisilicon.com, kevin.lixu@hisilicon.com, jalen.hsu@hisilicon.com
List-Id: linux-pwm@vger.kernel.org



On 2016/11/16 21:48, Rob Herring wrote:
> On Tue, Nov 15, 2016 at 08:41:32PM +0800, Jian Yuan wrote:
>> From: yuanjian <yuanjian12@hisilicon.com>
>>
>> Add PWM driver for the PWM controller found on HiSilicon BVT SOCs, like Hi3519V100, Hi3516CV300, etc.
> 
> Wrap your lines at ~72 chars.
> 
>> The PWM controller is primarily in charge of controlling P-Iris lens.
>>
>> Reviewed-by: Jiancheng Xue <xuejiancheng@hisilicon.com>
>> Signed-off-by: Jian Yuan <yuanjian12@hisilicon.com>
>> ---
>> Change Log:
>> v4:
>> Add #pwm-cells in the bindings document.
>> v3:
>> fixed issues pointed by thierry.
>> Add PWM compatible string for Hi3519V100.
>> Implement .apply() function which support atomic, instead of .enable()/.disable()/.config().
>> v2:
>> The number of PWMs is change to be probeable based on the compatible string.
>>
>>  .../devicetree/bindings/pwm/pwm-hibvt.txt          |  23 ++
>>  drivers/pwm/Kconfig                                |   9 +
>>  drivers/pwm/Makefile                               |   1 +
>>  drivers/pwm/pwm-hibvt.c                            | 270 +++++++++++++++++++++
>>  4 files changed, 303 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-hibvt.txt
>>  create mode 100644 drivers/pwm/pwm-hibvt.c
>>
>> diff --git a/Documentation/devicetree/bindings/pwm/pwm-hibvt.txt b/Documentation/devicetree/bindings/pwm/pwm-hibvt.txt
>> new file mode 100644
>> index 0000000..609284f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pwm/pwm-hibvt.txt
>> @@ -0,0 +1,23 @@
>> +Hisilicon PWM controller
>> +
>> +Required properties:
>> +-compatible: should contain one SoC specific compatible string and one generic compatible
> 
> ditto
> 
Ok.
>> +string "hisilicon, hibvt-pwm". The SoC specific strings supported including:
>> +	"hisilicon,hi3516cv300-pwm"
>> +	"hisilicon,hi3519v100-pwm"
>> +- reg: physical base address and length of the controller's registers.
>> +- clocks: phandle and clock specifier of the PWM reference clock.
>> +- resets: phandle and reset specifier for the PWM controller reset.
>> +- #pwm-cells: Should be 2. See pwm.txt in this directory for a description of
>> +  the cells format.
>> +
>> +Example:
>> +	pwm: pwm@12130000 {
>> +
>> +		compatible = "hisilicon,hi3516cv300-pwm", "hisilicon,hibvt-pwm";
>> +		compatible = "hisilicon,hi3519v100-pwm", "hisilicon,hibvt-pwm";
> 
> ??
> 
It had been removed in next patch v5. You can check it out.
With best wishes.
>> +		reg = <0x12130000 0x10000>;
>> +		clocks = <&crg_ctrl HI3516CV300_PWM_CLK>;
>> +		resets = <&crg_ctrl 0x38 0>;
>> +		#pwm-cells = <2>;
>> +	};
> 
> .
> 
