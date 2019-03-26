From: Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH 0/1] pwm: meson: fix scheduling while atomic issue
Date: Tue, 26 Mar 2019 09:37:12 +0100
Message-ID: <88a731b0f1c2ce18d2cf7aff6e2ffc24a395a067.camel@baylibre.com>
References: <20190324220217.15813-1-martin.blumenstingl@googlemail.com>
         <47e944da1c3b0a11cf46fc5ad5678ba961b9f9d3.camel@baylibre.com>
         <CAFBinCCPW8wAoiN4hjj9tAYSqQqChpSB6+urAiXU95VYaZZKGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAFBinCCPW8wAoiN4hjj9tAYSqQqChpSB6+urAiXU95VYaZZKGg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Kevin Hilman <khilman@baylibre.com>
Cc: thierry.reding@gmail.com, Neil Armstrong <narmstrong@baylibre.com>, linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Mon, 2019-03-25 at 19:04 +0100, Martin Blumenstingl wrote:
> > Thanks for fixing this Martin.
> you're welcome!
> 
> > As for the future enhancement, I'd like to know what you have in mind.
> > As I have told you previously, I think the clock bindings of this driver are
> > not great.
> > 
> > The global name of the input clocks are hard coded in this driver and it
> > sucks. CCF is evolving to rely less on these global names.
> I fully agree with you on the clock setup, but I'm not sure if we have
> to break the dt-bindings for it.
> 
> the datasheet notes: "Each PWM is driven by a programmable divider
> driven by a 4:1 clock selector".
> In my own words this means that each PWM controller has up to 8 clock inputs:
> - up to 4 inputs for the first channel (PWM_A)
> - up to 4 inputs for the second channel (PWM_B)

Not from the pwm device POV. there is one device (PWM_AB) with 4 (max) input
clocks. Those are consumed by two internal muxes. There would be 8 if the
input was different between path A and B.

> 
> the current pwm-meson driver assumes that both the inputs for both
> channels are identical.
> the "clock trees" section of the public S912 datasheet (page 65)
> clearly documents the clock inputs per PWM channel, not per PWM
> controller.
> 
> Thus I believe we should name our clock-names (the inputs to the PWM
> controller) "pwm-a-clkin0", "pwm-a-clkin1", "pwm-b-clkin0", ...
> That way we don't have a conflict with the existing bindings (which
> already reserve "clkin0" and "clkin1").

I think this is overkill an inaccurate. The experience of all the soc we have
seen so far (meson8, gxbb, gxl, gxm, axg and g12) confirms the sources the are
the same input clock for both path.

The documentation just shows the clock src of each pwm. That just how the the
table is presented. That does not change the fact the pwms are organized in
modules (pairs) and the that the clock source are the same for each pwm of the
module. IOW, there is only 4 lines of clocks getting to the IP, not 8. Feel
free to ask amlogic if you want to make sure.

The name clash is not really my point. The purpose of the clock binding would
be different (from stating a setting to describing hw connection)

> 
> > In addition, the 'clock' binding should be used to refer to the clock
> > 'consumed' by the device, not to define a setting (as done now). 'assigned-
> > clock' binding can be used for that.
> using the assigned-clock* properties requires self-referencing the PWM
> controller (which I'm not used to), for example:
>   &pwm_ab {
>       #clock-cells = <1>;
>       assigned-clocks = <&pwm_ab 0>, <&pwm_ab 1>; /* references itself */
>       assigned-clock-parents = <&xtal>, <&clkc CLKID_FCLK_DIV5>;
>   };
> 
> if we want to auto-detect the parent clock (like you suggested below)
> we need to consider if we can detect whether a .dts-author assigned a
> specific parent.

I (personally) don't want to keep supporting the manual assignment of the
parent. If the driver can guarantee than it will pick the most appropriate
parent, there is no reason to have that.

> I know that it's easy to detect this when the clock is passed in the
> "clocks" property, but I'm not sure if it's easy to parse it from the
> assigned-clocks/assigned-clock-parents properties.

Assigned parent is the poor man solution and not necessarily easier to
implement (the pwm device would have to export its own clocks) ... I have just
mentioned it to make  the point that current method is not ideal

> 
> [...]
> > Last, instead of specifying the parent to be used, I think we should come up
> > with some code to let the driver pick the most appropriate parent for the period/duty requested.
> that will make it easier for .dts authors.
> I would like to postpone this until we have solved the other topics though.

I much prefer this last solution. Since the algorithm and the bindings would
change, I think it would be easier (in DT) to just make v2 driver with a new
compatible, progressively transition dts to it and finally remove the old
driver.
