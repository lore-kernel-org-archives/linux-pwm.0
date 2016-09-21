From: Jian Yuan <yuanjian12-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
Subject: Re: [PATCH v3] pwm: add pwm driver for HiSilicon BVT SOCs
Date: Wed, 21 Sep 2016 14:12:54 +0800
Message-ID: <a46ed24c-0062-24a8-21ae-86fd34365df0@hisilicon.com>
References: <1473645106-42266-1-git-send-email-yuanjian12@hisilicon.com>
 <20160920144348.GA22856@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160920144348.GA22856@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, xuejiancheng-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, kevin.lixu-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, jalen.hsu-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org
List-Id: linux-pwm@vger.kernel.org



On 2016/9/20 22:43, Rob Herring wrote:
> On Mon, Sep 12, 2016 at 09:51:46AM +0800, Jian Yuan wrote:
>> From: yuanjian <yuanjian12-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
>>
>> Add PWM driver for the PWM controller found on HiSilicon BVT SOCs, like Hi3519V100, Hi3516CV300, etc.
>> The PWM controller is primarily in charge of controlling P-Iris lens.
>>
>> Reviewed-by: Jiancheng Xue <xuejiancheng-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
>> Signed-off-by: Jian Yuan <yuanjian12-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
>> ---
>> Change Log:
>> v3:
>> Add PWM compatible string for Hi3519V100.
>> Implement .apply() function which support atomic, instead of .enable()/.disable()/.config().
>> v2:
>> The number of PWMs is change to be probeable based on the compatible string.
>>
>>  .../devicetree/bindings/pwm/pwm-hibvt.txt          |  20 ++
>>  drivers/pwm/Kconfig                                |   9 +
>>  drivers/pwm/Makefile                               |   1 +
>>  drivers/pwm/pwm-hibvt.c                            | 270 +++++++++++++++++++++
>>  4 files changed, 300 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-hibvt.txt
>>  create mode 100644 drivers/pwm/pwm-hibvt.c
>>
>> diff --git a/Documentation/devicetree/bindings/pwm/pwm-hibvt.txt b/Documentation/devicetree/bindings/pwm/pwm-hibvt.txt
>> new file mode 100644
>> index 0000000..2ecf4e4
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pwm/pwm-hibvt.txt
>> @@ -0,0 +1,20 @@
>> +Hisilicon PWM controller
>> +
>> +Required properties:
>> +-compatible: should contain one SoC specific compatible string and one generic compatible
>> +string "hisilicon, hibvt-pwm". The SoC specific strings supported including:
>> +	"hisilicon,hi3516cv300-pwm"
>> +	"hisilicon,hi3519v100-pwm"
>> +- reg: physical base address and length of the controller's registers.
>> +- clocks: phandle and clock specifier of the PWM reference clock.
>> +- resets: phandle and reset specifier for the PWM controller reset.
> 
> You are missing #pwm-cells.
> 
Ok, thanks.

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
