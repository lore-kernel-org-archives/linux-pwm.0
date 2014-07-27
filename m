Return-Path: <caesar.wang@rock-chips.com>
Message-ID: <53D500E0.5010405@rock-chips.com>
Date: Sun, 27 Jul 2014 21:38:40 +0800
From: caesar <caesar.wang@rock-chips.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/2] pwm: add this patch to support the new pwm of
 Rockchip SoCs
References: <1405774529-26027-1-git-send-email-caesar.wang@rock-chips.com>	<1405774529-26027-3-git-send-email-caesar.wang@rock-chips.com>	<20140721085001.GG8843@ulmo>	<53CD0E82.6030901@rock-chips.com>	<20140721132723.GH15238@ulmo>	<53D23192.4000908@rock-chips.com> <CAD=FV=XLjYQYmHxp3HBdwVmt6Wa7y-LEnsFKobsgVfFCp2-rRg@mail.gmail.com>
In-Reply-To: <CAD=FV=XLjYQYmHxp3HBdwVmt6Wa7y-LEnsFKobsgVfFCp2-rRg@mail.gmail.com>
Content-Type: multipart/alternative;
 boundary="------------060605040607060203090501"
List-ID: <linux-pwm.vger.kernel.org>
To: Doug Anderson <dianders@chromium.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

This is a multi-part message in MIME format.
--------------060605040607060203090501
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

Hi Doug,

在 2014年07月27日 12:59, Doug Anderson 写道:
> caesar,
>
> On Fri, Jul 25, 2014 at 3:29 AM, caesar <caesar.wang@rock-chips.com> wrote:
>> Hi Thierry,
>>
>>
>>
>>
>> 在 2014年07月21日 21:27, Thierry Reding 写道:
>>> On Mon, Jul 21, 2014 at 08:58:42PM +0800, caesar wrote:
>>>
>>>> 于 2014年07月21日 16:50, Thierry Reding 写道:
>>>>> On Sat, Jul 19, 2014 at 08:55:29PM +0800, Caesar Wang wrote:
>>> [...]
>>>>>>          struct rockchip_pwm_chip *pc;
>>>>>>          struct resource *r;
>>>>>>          int ret;
>>>>>> @@ -119,7 +182,10 @@ static int rockchip_pwm_probe(struct
>>>>>> platform_device *pdev)
>>>>>>                  return -ENOMEM;
>>>>>>          r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>>>>> -       pc->base = devm_ioremap_resource(&pdev->dev, r);
>>>>>> +       if (!strcmp(of_id->compatible, "rockchip,vop-pwm"))
>>>>>> +               pc->base = devm_ioremap(&pdev->dev, r->start,
>>>>>> resource_size(r));
>>>>>> +       else
>>>>>> +               pc->base = devm_ioremap_resource(&pdev->dev, r);
>>>>> Sorry, this still isn't an option. You really shouldn't remap I/O
>>>>> regions that other drivers may be using. You hinted at a shared register
>>>>> space during the review of the initial version. Can you provide more
>>>>> detail about what exactly the memory map looks like of the rk3288? Is
>>>>> there some kind of technical reference manual that I could look at? Or
>>>>> do you have a device tree extract that shows what the memory map looks
>>>>> like?
>>>>>
>>>>> Thierry
>>>> Maybe,you can look at the ARM: dts: rk3288:
>>>>
>>>> https://github.com/rkchrome/kernel/blob/master/arch/arm/boot/dts/rk3288.dtsi
>>>> There is some lcdc and vop-pwm map address for rk3288.
>>>>
>>>> ,and you can look at the vop-introduce.pdf and vop-register.pdf in Annex.
>>>>
>>>> Maybe,I should put the vop-pwm in lcdc driver,but I don't hope do so it.
>>>>
>>>> Could you give a suggestion to solve it? Thanks.
>>> It looks like you could turn the lcdc device into an MFD device so that
>>> it can instantiate two devices, one for the display controller, the
>>> other for the PWM. Or perhaps it would even work with only a single
>>> child device.
>>>
>>> The device tree would become something like this:
>>>
>>>          lcdc@ff930000 {
>>>                  compatible = "rockchip,rk3288-lcdc";
>>>                  ...
>>>
>>>                  pwm@ff9301a0 {
>>>                          compatible = "rockchip,vop-pwm";
>>>                          ...
>>>                  };
>>>          };
>>>
>>> And your driver would do something like:
>>>
>>>          static const struct resource pwm_resources[] = {
>>>                  {
>>>                          .start = 0x1a0,
>>>                          .end = 0x1af,
>>>                          .flags = IORESOURCE_MEM,
>>>                  },
>>>          };
>>>
>>>          static const struct mfd_cell subdevices[] = {
>>>                  {
>>>                          .name = "pwm",
>>>                          .id = 1,
>>>                          .of_compatible = "rockchip,vop-pwm",
>>>                          .num_resources = ARRAY_SIZE(pwm_resources),
>>>                          .resources = pwm_resources,
>>>                  },
>>>          };
>>>
>>>          static int lcdc_probe(struct platform_device *pdev)
>>>          {
>>>                  struct resource *regs;
>>>                  ...
>>>
>>>                  regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>>
>>>                  ...
>>>
>>>                  err = mfd_add_devices(&pdev->dev, 0, subdevices,
>>> ARRAY_SIZE(subdevices),
>>>                                        regs, NULL, NULL);
>>>                  ...
>>>          }
>>>
>>> Thierry
>> Sorry,I might a little trouble for the changes.
>>
>> The driver changes only for lcdc? If that is the case,I suddenly don't know
>> how to do it ?
>>
>> Maybe,I didn't say it clearly.
>>
>> lcdc0: lcdc@ff930000                   |     vop0pwm: pwm@ff9301a0
>> reg = <0xff930000 0x10000>     |      reg = <0xff9301a0 0x10>;
>>
>> The lcdc has to add resource's address  from  0xff930000 to 0xff93ffff.
>>
>> When the  pwm driver is loading vop0pwm. the "devm_ioremap_resource()" will
>> be used in probe();
>>
>> I think it will be occur a fail. because the resource [mem
>> 0xff9301a0-0xff9301af] has be requested by lcdc.
>> =>rockchip-pwm ff9301a0.pwm: can't request region for resource [mem
>> 0xff9301a0-0xff9301af]
>>
>> If I do the changes in pwm driver,do you have a other suggestion for it?
>> thanks.:-)
> Sorry if this is stupid (and I haven't tried it), but does "ranges"
> help solve this problem?  AKA:
>
>           lcdc@ff930000 {
>                   compatible = "rockchip,rk3288-lcdc";
>                   reg = <0xff930000 0x10000>;
>                   #address-cells = <2>;
>                   #size-cells = <1>;
>                   ranges = <0 0xff9301a0 0x10>;
>                   ...
>
>                   pwm@0,0 {
>                           compatible = "rockchip,vop-pwm";
>                           reg = <0 0 0x10>;
>                          ...
>                   };
>           };
>
> Does that avoid the failure?  The lcdc driver would need to call
> of_platform_populate() to make the PWM show up.
>
>
Sorry  if  I  got it wrong following  your way.

example: ARM: DTS:

lcdc@ff930000 {
                  compatible = "rockchip,rk3288-lcdc";
                  reg = <0xff930000 0x10000>;
                  #address-cells = <2>;
                  #size-cells = <1>;
                  ranges = <0 0xff9301a0 0x10>;
                  ...

                  pwm@0,0 {
                          compatible = "rockchip,vop-pwm";
                          reg = <0 0 0x10>;
                         ...
                  };
          };


*The LCDC drive*r ,as follws:

static const struct of_device_id vop_pwm_dt_ids[] = {

     {.compatible = "rockchip,vop-pwm",},

     {}

};

static int lcdc_probe(struct platform_device *pdev)
         {
                 struct resource *regs;
		int ret = 0;
		...
		
		/*This step will get resource=[mem 0xff930000-0yff93ffff]*/

                 regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);

                 ...

                 *lcdc_dev->regs = devm_ioremap_resource(dev, regs);*
	
		...

		/*This step will make enable vop-pwm in PWM driver?*/

		ret = of_platform_populate(np, vop_pwm_dt_ids, NULL, &pdev->dev);
		
		...
	 }


*The PWM driver:*

static const struct of_device_id rockchip_pwm_dt_ids[] = {

     { .compatible = "rockchip,rk2928-pwm", .data = &pwm_data_v1},

     { .compatible = "rockchip,rk3288-pwm", .data = &pwm_data_v2},

     { .compatible = "rockchip,vop-pwm", .data = &pwm_data_vop},

     { /* sentinel */ }

};


static int rockchip_pwm_probe(struct platform_device *pdev)
         {
                 struct resource *regs;
		int ret = 0;
		...
		
		/*This step ,if it's "rockchip,vop-pwm",the resource=[mem 0xff9301a0-0yff9301af]*/

                 regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);

                 ...
		
		/*I think will be show the log:->
		 * rockchip-pwm ff9301a0.pwm: can't request region for resource [mem 0xff9301a0-0xff9301af] ?
		*/


                 *lcdc_dev->regs = devm_ioremap_resource(dev, regs);*
	
		...

		

		ret = of_platform_populate(np, vop_pwm_dt_ids, NULL, &pdev->dev);
		
		...
	 }





--------------060605040607060203090501
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    Hi Doug,<br>
    <br>
    <div class="moz-cite-prefix">在 2014年07月27日 12:59, Doug Anderson 写道:<br>
    </div>
    <blockquote
cite="mid:CAD=FV=XLjYQYmHxp3HBdwVmt6Wa7y-LEnsFKobsgVfFCp2-rRg@mail.gmail.com"
      type="cite">
      <pre wrap="">caesar,

On Fri, Jul 25, 2014 at 3:29 AM, caesar <a class="moz-txt-link-rfc2396E" href="mailto:caesar.wang@rock-chips.com">&lt;caesar.wang@rock-chips.com&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">Hi Thierry,




在 2014年07月21日 21:27, Thierry Reding 写道:
</pre>
        <blockquote type="cite">
          <pre wrap="">
On Mon, Jul 21, 2014 at 08:58:42PM +0800, caesar wrote:

</pre>
          <blockquote type="cite">
            <pre wrap="">于 2014年07月21日 16:50, Thierry Reding 写道:
</pre>
            <blockquote type="cite">
              <pre wrap="">
On Sat, Jul 19, 2014 at 08:55:29PM +0800, Caesar Wang wrote:
</pre>
            </blockquote>
          </blockquote>
          <pre wrap="">
[...]
</pre>
          <blockquote type="cite">
            <blockquote type="cite">
              <blockquote type="cite">
                <pre wrap="">
        struct rockchip_pwm_chip *pc;
        struct resource *r;
        int ret;
@@ -119,7 +182,10 @@ static int rockchip_pwm_probe(struct
platform_device *pdev)
                return -ENOMEM;
        r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-       pc-&gt;base = devm_ioremap_resource(&amp;pdev-&gt;dev, r);
+       if (!strcmp(of_id-&gt;compatible, "rockchip,vop-pwm"))
+               pc-&gt;base = devm_ioremap(&amp;pdev-&gt;dev, r-&gt;start,
resource_size(r));
+       else
+               pc-&gt;base = devm_ioremap_resource(&amp;pdev-&gt;dev, r);
</pre>
              </blockquote>
              <pre wrap="">
Sorry, this still isn't an option. You really shouldn't remap I/O
regions that other drivers may be using. You hinted at a shared register
space during the review of the initial version. Can you provide more
detail about what exactly the memory map looks like of the rk3288? Is
there some kind of technical reference manual that I could look at? Or
do you have a device tree extract that shows what the memory map looks
like?

Thierry
</pre>
            </blockquote>
            <pre wrap="">
Maybe,you can look at the ARM: dts: rk3288:

<a class="moz-txt-link-freetext" href="https://github.com/rkchrome/kernel/blob/master/arch/arm/boot/dts/rk3288.dtsi">https://github.com/rkchrome/kernel/blob/master/arch/arm/boot/dts/rk3288.dtsi</a>
There is some lcdc and vop-pwm map address for rk3288.

,and you can look at the vop-introduce.pdf and vop-register.pdf in Annex.

Maybe,I should put the vop-pwm in lcdc driver,but I don't hope do so it.

Could you give a suggestion to solve it? Thanks.
</pre>
          </blockquote>
          <pre wrap="">
It looks like you could turn the lcdc device into an MFD device so that
it can instantiate two devices, one for the display controller, the
other for the PWM. Or perhaps it would even work with only a single
child device.

The device tree would become something like this:

        lcdc@ff930000 {
                compatible = "rockchip,rk3288-lcdc";
                ...

                pwm@ff9301a0 {
                        compatible = "rockchip,vop-pwm";
                        ...
                };
        };

And your driver would do something like:

        static const struct resource pwm_resources[] = {
                {
                        .start = 0x1a0,
                        .end = 0x1af,
                        .flags = IORESOURCE_MEM,
                },
        };

        static const struct mfd_cell subdevices[] = {
                {
                        .name = "pwm",
                        .id = 1,
                        .of_compatible = "rockchip,vop-pwm",
                        .num_resources = ARRAY_SIZE(pwm_resources),
                        .resources = pwm_resources,
                },
        };

        static int lcdc_probe(struct platform_device *pdev)
        {
                struct resource *regs;
                ...

                regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);

                ...

                err = mfd_add_devices(&amp;pdev-&gt;dev, 0, subdevices,
ARRAY_SIZE(subdevices),
                                      regs, NULL, NULL);
                ...
        }

Thierry
</pre>
        </blockquote>
        <pre wrap="">
Sorry,I might a little trouble for the changes.

The driver changes only for lcdc? If that is the case,I suddenly don't know
how to do it ?

Maybe,I didn't say it clearly.

lcdc0: lcdc@ff930000                   |     vop0pwm: pwm@ff9301a0
reg = &lt;0xff930000 0x10000&gt;     |      reg = &lt;0xff9301a0 0x10&gt;;

The lcdc has to add resource's address  from  0xff930000 to 0xff93ffff.

When the  pwm driver is loading vop0pwm. the "devm_ioremap_resource()" will
be used in probe();

I think it will be occur a fail. because the resource [mem
0xff9301a0-0xff9301af] has be requested by lcdc.
=&gt;rockchip-pwm ff9301a0.pwm: can't request region for resource [mem
0xff9301a0-0xff9301af]

If I do the changes in pwm driver,do you have a other suggestion for it?
thanks.:-)
</pre>
      </blockquote>
      <pre wrap="">
Sorry if this is stupid (and I haven't tried it), but does "ranges"
help solve this problem?  AKA:

         lcdc@ff930000 {
                 compatible = "rockchip,rk3288-lcdc";
                 reg = &lt;0xff930000 0x10000&gt;;
                 #address-cells = &lt;2&gt;;
                 #size-cells = &lt;1&gt;;
                 ranges = &lt;0 0xff9301a0 0x10&gt;;
                 ...

                 pwm@0,0 {
                         compatible = "rockchip,vop-pwm";
                         reg = &lt;0 0 0x10&gt;;
                        ...
                 };
         };

Does that avoid the failure?  The lcdc driver would need to call
of_platform_populate() to make the PWM show up.


</pre>
    </blockquote>
    Sorry  if  I  got it wrong following  your way. <br>
    <br>
    example: ARM: DTS:<br>
    <pre wrap="">lcdc@ff930000 {
                 compatible = "rockchip,rk3288-lcdc";
                 reg = &lt;0xff930000 0x10000&gt;;
                 #address-cells = &lt;2&gt;;
                 #size-cells = &lt;1&gt;;
                 ranges = &lt;0 0xff9301a0 0x10&gt;;
                 ...

                 pwm@0,0 {
                         compatible = "rockchip,vop-pwm";
                         reg = &lt;0 0 0x10&gt;;
                        ...
                 };
         };</pre>
    <br>
    <b>The LCDC drive</b>r ,as follws:<br>
    <br>
    <pre>static const struct of_device_id vop_pwm_dt_ids[] = {</pre>
    <pre>    {.compatible = "rockchip,vop-pwm",},</pre>
    <pre>    {}</pre>
    <pre>};</pre>
    <pre wrap="">static int lcdc_probe(struct platform_device *pdev)
        {
                struct resource *regs;
		int ret = 0;
		...
		
		<font color="#ff0000">/*This step will get resource=[mem 0xff930000-0yff93ffff]*</font><font color="#ff0000">/</font>

                regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);

                ...

                <b>lcdc_dev-&gt;regs = devm_ioremap_resource(dev, regs);</b>
	
		...

<font color="#ff0000">		/*This step will make enable vop-pwm in PWM driver?*</font><font color="#ff0000">/</font>

		ret = of_platform_populate(np, vop_pwm_dt_ids, NULL, &amp;pdev-&gt;dev);
		
		...
	 }</pre>
    <tt><br>
    </tt>
    <pre><b><tt>The PWM driver:</tt></b></pre>
    <pre><tt>static const struct of_device_id rockchip_pwm_dt_ids[] = {</tt></pre>
    <pre><tt>    { .compatible = "rockchip,rk2928-pwm", .data = &amp;pwm_data_v1},</tt></pre>
    <pre><tt>    { .compatible = "rockchip,rk3288-pwm", .data = &amp;pwm_data_v2},</tt></pre>
    <pre><tt>    { .compatible = "rockchip,vop-pwm", .data = &amp;pwm_data_vop},</tt></pre>
    <pre><tt>    { /* sentinel */ }</tt></pre>
    <pre><tt>};</tt></pre>
    <br>
    <pre wrap="">static int rockchip_pwm_probe(struct platform_device *pdev)
        {
                struct resource *regs;
		int ret = 0;
		...
<font color="#ff0000">		
		/*This step ,if it's "</font><font color="#ff0000"><tt>rockchip,vop-pwm</tt>",the resource=[mem 0xff9301a0-0yff9301af]*</font><font color="#ff0000">/</font>

                regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);

                ...
		
		<font color="#ff0000">/*I think will be show the log:-&gt; </font><font color="#ff0000">
		 * rockchip-pwm ff9301a0.pwm: can't request region for resource [mem 0xff9301a0-0xff9301af] ?
		*</font><font color="#ff0000">/</font>


                <b>lcdc_dev-&gt;regs = devm_ioremap_resource(dev, regs);</b>
	
		...

<font color="#ff0000">		</font>

		ret = of_platform_populate(np, vop_pwm_dt_ids, NULL, &amp;pdev-&gt;dev);
		
		...
	 }</pre>
    <br>
       <br>
    <blockquote
cite="mid:CAD=FV=XLjYQYmHxp3HBdwVmt6Wa7y-LEnsFKobsgVfFCp2-rRg@mail.gmail.com"
      type="cite">
      <pre wrap="">
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------060605040607060203090501--
