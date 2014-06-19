From: Boris BREZILLON <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v2 4/7] ARM: at91/dt: split sama5d3 lcd pin definitions
 to match RGB mode configs
Date: Thu, 19 Jun 2014 09:40:19 +0200
Message-ID: <53A293E3.6000707@free-electrons.com>
References: <1402329860-27520-1-git-send-email-boris.brezillon@free-electrons.com> <1402329860-27520-5-git-send-email-boris.brezillon@free-electrons.com> <53A28C2C.1010001@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <53A28C2C.1010001@atmel.com>
Sender: linux-doc-owner@vger.kernel.org
To: Bo Shen <voice.shen@atmel.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, David Airlie <airlied@linux.ie>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org, Jean-Jacques Hiblot <jjhiblot@traphandler.com>, linux-doc@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Hello Bo,

On 19/06/2014 09:07, Bo Shen wrote:
> Hi Boris,
>
> On 06/10/2014 12:04 AM, Boris BREZILLON wrote:
>> The HLCDC (High LCD Controller) IP supports 4 different output mode
>> (RGB444, RGB565, RGB666 and RGB888) and the pin muxing depends on the
>> chosen RGB mode.
>>
>> Split the pin definition to be able to set the pin config according
>> to the
>> selected mode.
>>
>> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
>> ---
>>   arch/arm/boot/dts/sama5d3_lcd.dtsi | 127
>> ++++++++++++++++++++++++++++---------
>>   1 file changed, 96 insertions(+), 31 deletions(-)
>
> On sama5d3xek board, it only works in 24bits output mode. And it
> depends on the hardware design. So, I think only keep only one pinctrl
> configuration.

I'm not describing a specific board design but rather SoC capabilities
(this dtsi is SoC related not board related), and the sama5d3 SoC
supports 4 different RGB output modes through the RGB connector.

If you take a look at patch 7, you'll see that I chose mode 3 (which is
RGB888), and given this mode the HLCDC driver (atmel_hlcdc_panel.c) will
request the appropriate pin state:

atmel,panel = <&panel 3 0>;


Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

