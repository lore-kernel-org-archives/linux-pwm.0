From: Romain Izard <romain.izard.pro@gmail.com>
Subject: Re: [PATCH v3] pwm: add CSR SiRFSoC PWM driver
Date: Fri, 28 Feb 2014 10:06:07 +0100
Message-ID: <CAMiSF3CN33N867TtjatYx1EwaV5qJY=JYsSrVFpQvC+yS1T5rA@mail.gmail.com>
References: <1391855002-26098-1-git-send-email-21cnbao@gmail.com>
 <lel46f$q2d$1@ger.gmane.org>
 <CAGsJ_4xLtXV6WtVhLgzFAaU9oG5UOt+LonFktBipQf_a6Yutng@mail.gmail.com>
 <CAMiSF3CczVV+Ob++_ACcwE+OXvFH8f9v1E=Q1F5x7Zz1BjCCzg@mail.gmail.com>
 <CAGsJ_4ywPTbUnfVVFFNFMSwG0CGckxKqHZ81rvEDFK-_1H25tA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAGsJ_4ywPTbUnfVVFFNFMSwG0CGckxKqHZ81rvEDFK-_1H25tA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Barry Song <21cnbao@gmail.com>
Cc: linux-pwm@vger.kernel.org, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pwm@vger.kernel.org

Hello Barry,

2014-02-28 4:01 GMT+01:00 Barry Song <21cnbao@gmail.com>:
>
> Hi Romain,
>
> do you have a real user scenarios for this 32KHz? as the 1st step, i
> want a clean and general enough pwm driver, if there is any special
> requirement, i want to execute a "demanding page" when the "page
> fault" happened as this will make the whole flow more smooth. that
> means we make it lazy by incremental patches. but if you do want to
> use it for the moment, it is a "page fault" now. so we can have it
> immediately and it is better you can help to double-test :-)

My use case is to connect a Bluetooth module, in fact with a CSR chip.
For testing, I will try to see what I can do, as for now my boards are not
running with the mainline. But I'm very interested in transitioning on the
mainline in due time, so that's the reason I keep an eye on the mailing
lists. Conversely, it's not critical at all to get the feature in right now, but
it should not be impossible to do so in the future, especially when taking
the 'stable interface' aspect of device tree bindings into account.

> 2014-02-27 18:51 GMT+08:00 Romain Izard <romain.izard.pro@gmail.com>:
>> Perhaps this can be linked with the missing "clock-names" property, as this
>> will make it possible to add multiple functional clocks, with "iclk" matching
>> the interface clock (i.e. pwmc), and "fclk0", "fclk1", etc. matching
>> all supported
>> functional clocks.
>>
>> With only the 26 MHz clock, the node would look like:
>>
>> pwm: pwm@b0130000 {
>>         compatible = "sirf,prima2-pwm";
>>         #pwm-cells = <2>;
>>         reg = <0xb0130000 0x10000>;
>>         clocks = <&clks 21>,  <&clks 1>, <&clks 0>;
>>         clock-names = "iclk", "fclk0", "fclk3";
>> };
>>

Aargh. I meant this:

pwm: pwm@b0130000 {
        compatible = "sirf,prima2-pwm";
        #pwm-cells = <2>;
        reg = <0xb0130000 0x10000>;
        clocks = <&clks 21>,  <&clks 1>;
        clock-names = "iclk", "fclk0";
};

>> The result would look like this with both the 26 MHz and the 32 kHz clocks:
>>
>> pwm: pwm@b0130000 {
>>         compatible = "sirf,prima2-pwm";
>>         #pwm-cells = <2>;
>>         reg = <0xb0130000 0x10000>;
>>         clocks = <&clks 21>,  <&clks 1>, <&clks 0>;
>>         clock-names = "iclk", "fclk0", "fclk3";
>> };
>>
>> And with all possible clocks:
>>
>> pwm: pwm@b0130000 {
>>         compatible = "sirf,prima2-pwm";
>>         #pwm-cells = <2>;
>>         reg = <0xb0130000 0x10000>;
>>         clocks = <&clks 21>,  <&clks 1>, <&clks 2>, <&clks 3>, <&clks
>> 0>, <&clks 4>;
>>         clock-names = "iclk", "fclk0", "fclk1", "fclk2", "fclk3", "fclk4";
>> };
>>
>> The code in the probe function would interpret the clock-name to build
>> the clock/index mapping table. This would not change a lot the binding you
>> proposed, as you still can describe only one functional clock, but it describes
>> which index in the configuration register is linked to the proposed clock.
>>
>
> yes. very clear. the only two things left
>
> 1.  fclk should be named for pwm not for rtc, osc and pll, so the
> names might be ugly by fclk0~N.
>
For me, it's important to keep the number in the name of the clock as it is
the source of the information for binding the device tree clock on one side
and the clock source index in the selection register on the other side. If
we do not do it this way, we cannot easily handle new clocks in the future
in the binding.

On the other hand, I strongly dislike the current clock specification
as <&clks #x>.
It would be probably a good thing to add a header linking the numbers
to symbols,
and we would then get:

        clocks = <&clks SIRFCLK_A6_PWM>,
                <&clks SIRFCLK_A6_OSC>,
                <&clks SIRFCLK_A6_PLL1>,
                <&clks SIRFCLK_A6_PLL2>,
                <&clks SIRFCLK_A6_RTC>,
                <&clks SIRFCLK_16_PLL3>;
        clock-names = "iclk", "fclk0", "fclk1", "fclk2", "fclk3", "fclk4";

Note that as the binary output of the device tree would not change with this, we
do not need to worry about backwards compatibility in this precise case.

> 2.  the driver need to manage all of the clocks. yes, it can. but it
> might be ugly again. we can either request the clk at the time of pwm
> configuration, or get all directy in probe and maintain an array.

For me, what is important right now is to get the binding right. If the driver
cannot do everything the binding allows, this is not a problem. But we define
a binding that cannot easily be expanded, we will have problems when we
need the new features.

> i am thinking what is the best way for it. if we do that by an
> incremental patch, it might be more concentrated and understandable.

I'm all for this as well, that why for me the first syntax (corrected
up there) should
be valid. This way, you do not need to integrate the bypass support in
this step,
but you can add it later.

Best regards,
-- 
Romain Izard
