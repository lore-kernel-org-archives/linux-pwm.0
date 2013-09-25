Return-Path: <alexandre.belloni@free-electrons.com>
Message-ID: <5242E1D5.5000503@free-electrons.com>
Date: Wed, 25 Sep 2013 15:15:01 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
Subject: Re: [PATCH v4] PWM: atmel-pwm: add PWM controller driver
References: <1380079664-21959-1-git-send-email-voice.shen@atmel.com> <524290F5.2090406@atmel.com>
In-Reply-To: <524290F5.2090406@atmel.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-ID: <linux-pwm.vger.kernel.org>
To: Nicolas Ferre <nicolas.ferre@atmel.com>, Bo Shen <voice.shen@atmel.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, plagnioj@jcrosoft.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On 25/09/2013 09:29, Nicolas Ferre wrote:
> On 25/09/2013 05:27, Bo Shen :
>> Add Atmel PWM controller driver based on PWM framework.
>>
>> This is the basic function implementation of Atmel PWM controller.
>> It can work with PWM based led and backlight.
>>
>> Signed-off-by: Bo Shen <voice.shen@atmel.com>
>
> It seems simple and nice.
>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Tested on a sama5d31 board with leds-pwm.

Tested-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
