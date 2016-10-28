From: Jian Yuan <yuanjian12@hisilicon.com>
Subject: Re: [PATCH v4] pwm: add pwm driver for HiSilicon BVT SOCs
Date: Fri, 28 Oct 2016 10:56:08 +0800
Message-ID: <3a69d460-8217-73e5-f132-8789a9728bce@hisilicon.com>
References: <1476097516-164577-1-git-send-email-yuanjian12@hisilicon.com>
 <20161010215339.GA21660@rob-hp-laptop> <20161021072236.GD2670@ulmo.ba.sec>
 <20161021073457.GF2670@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161021073457.GF2670@ulmo.ba.sec>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh@kernel.org>
Cc: mark.rutland@arm.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, xuejiancheng@hisilicon.com, kevin.lixu@hisilicon.com, jalen.hsu@hisilicon.com
List-Id: linux-pwm@vger.kernel.org



On 2016/10/21 15:34, Thierry Reding wrote:
> On Fri, Oct 21, 2016 at 09:22:36AM +0200, Thierry Reding wrote:
>> On Mon, Oct 10, 2016 at 04:53:39PM -0500, Rob Herring wrote:
>>> On Mon, Oct 10, 2016 at 07:05:16PM +0800, Jian Yuan wrote:
>>>> From: yuanjian <yuanjian12@hisilicon.com>
>>>>
>>>> Add PWM driver for the PWM controller found on HiSilicon BVT SOCs, like Hi3519V100, Hi3516CV300, etc.
>>>> The PWM controller is primarily in charge of controlling P-Iris lens.
>>>>
>>>> Reviewed-by: Jiancheng Xue <xuejiancheng@hisilicon.com>
>>>> Signed-off-by: Jian Yuan <yuanjian12@hisilicon.com>
>>>> ---
>>>> Change Log:
>>>> v4:
>>>> Add #pwm-cells in the bindings document.
>>>> v3:
>>>> fixed issues pointed by thierry.
>>>> Add PWM compatible string for Hi3519V100.
>>>> Implement .apply() function which support atomic, instead of .enable()/.disable()/.config().
>>>> v2:
>>>> The number of PWMs is change to be probeable based on the compatible string.
>>>>
>>>>  .../devicetree/bindings/pwm/pwm-hibvt.txt          |  23 ++
>>>>  drivers/pwm/Kconfig                                |   9 +
>>>>  drivers/pwm/Makefile                               |   1 +
>>>>  drivers/pwm/pwm-hibvt.c                            | 270 +++++++++++++++++++++
>>>>  4 files changed, 303 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-hibvt.txt
>>>>  create mode 100644 drivers/pwm/pwm-hibvt.c
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/pwm/pwm-hibvt.txt b/Documentation/devicetree/bindings/pwm/pwm-hibvt.txt
>>>> new file mode 100644
>>>> index 0000000..609284f
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/pwm/pwm-hibvt.txt
>>>> @@ -0,0 +1,23 @@
>>>> +Hisilicon PWM controller
>>>> +
>>>> +Required properties:
>>>> +-compatible: should contain one SoC specific compatible string and one generic compatible
>>>> +string "hisilicon, hibvt-pwm". The SoC specific strings supported including:
>>>
>>> Extra space          ^
>>>
>>> With that, for the binding:
>>>
>>> Acked-by: Rob Herring <robh@kernel.org>
>>
>> I'm wondering what the use is of the generic compatible string? Not only
>> is the driver not listing it, nor is it in any way useful since there is
>> nothing the driver could do based on the generic compatible string (each
>> version of the IP currently supported has a different number of PWM
>> channels).
> 
> Actually it's worse. The driver does have an entry for the generic
> compatible string but it doesn't assign .data in that case (which is
> really what I was saying above). Now according to the bindings it is
> disallowed to have only the generic compatible string, which is good
> because doing so would crash the driver on probe.
> 
> So, if it's not allowed to have only the generic compatible string,
> why even have one at all? We always have an SoC-specific compatible
> string as well, so the generic one is completely redundant.
> 
> Thierry
> 

Hi, Thierry, are there some other issue about driver except the generic compatible string? awaiting your reply.
thanks.

Jian Yuan.
