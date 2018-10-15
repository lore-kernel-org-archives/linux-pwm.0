From: Atish Patra <atish.patra@wdc.com>
Subject: Re: [RFC 1/4] pwm: sifive: Add DT documentation for SiFive PWM
 Controller.
Date: Mon, 15 Oct 2018 15:57:35 -0700
Message-ID: <25758ab9-eb36-741b-6264-42412b3ddd8e@wdc.com>
References: <1539111085-25502-1-git-send-email-atish.patra@wdc.com>
 <1539111085-25502-2-git-send-email-atish.patra@wdc.com>
 <20181010134926.GD21134@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181010134926.GD21134@ulmo>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Wesley Terpstra <wesley@sifive.com>
Cc: palmer@sifive.com, linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org, linus.walleij@linaro.org, robh+dt@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com, hch@infradead.org
List-Id: linux-pwm@vger.kernel.org

On 10/10/18 6:49 AM, Thierry Reding wrote:
> On Tue, Oct 09, 2018 at 11:51:22AM -0700, Atish Patra wrote:
>> From: "Wesley W. Terpstra" <wesley@sifive.com>
>>
>> DT documentation for PWM controller added with updated compatible
>> string.
>>
>> Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
>> [Atish: Compatible string update]
>> Signed-off-by: Atish Patra <atish.patra@wdc.com>
>> ---
>>   .../devicetree/bindings/pwm/pwm-sifive.txt         | 32 ++++++++++++++++++++++
>>   1 file changed, 32 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sifive.txt
>>
>> diff --git a/Documentation/devicetree/bindings/pwm/pwm-sifive.txt b/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
>> new file mode 100644
>> index 00000000..532b10fc
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
>> @@ -0,0 +1,32 @@
>> +SiFive PWM controller
>> +
>> +Unlike most other PWM controllers, the SiFive PWM controller currently only
>> +supports one period for all channels in the PWM. This is set globally in DTS.
>> +The period also has significant restrictions on the values it can achieve,
>> +which the driver rounds to the nearest achievable frequency.
> 
> What restrictions are these? If "nearest achievable" is too far off the
> target period it might be preferable to error out.
> 

@Wes: Any comments?

>> +Required properties:
>> +- compatible: should be one of
>> +	"sifive,fu540-c000-pwm0","sifive,pwm0".
> 
> What's the '0' in here? A version number?
>

I think yes. Since fu540 is the first Linux capable RISC-V core, SiFive 
Guys decided mark it as version 0.

@Wesly: Please correct me if I am wrong.

>> +	PWM controller is HiFive Unleashed specific chip which warrants a
>> +	specific compatible string. The second string is kept for backward
>> +	compatibility until a firmware update with latest compatible string.
>> +- reg: physical base address and length of the controller's registers
>> +- clocks: The frequency the controller runs at
>> +- #pwm-cells: Should be 2.
>> +  The first cell is the PWM channel number
>> +  The second cell is the PWM polarity
>> +- sifive,approx-period: the driver will get as close to this period as it can
> 
> Given the above comment, maybe "sifive,period"?
> 

ok.
In Unleashed board, the DT is loaded by FSBL (first stage boot loader). 
Thus, changing device tree entries requires a FSBL update. If we update 
this string, we need to update the driver to parse both properties so 
that existing devices with older firmware continue to work.

This is probably ok as we anyways do that for compatible strings. Just 
wanted to update that here for the record.

Regards,
Atish
> Thierry
> 
