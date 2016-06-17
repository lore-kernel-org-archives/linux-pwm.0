From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2 2/4] mfd: cros_ec: add EC_PWM function definitions
Date: Fri, 17 Jun 2016 08:28:23 -0700
Message-ID: <CAD=FV=UUJt4vBwHJrUYrKN56dv2YqdW3R7wah7-_PqyQ=YYr7Q@mail.gmail.com>
References: <1464916904-37554-1-git-send-email-briannorris@chromium.org>
 <1464916904-37554-3-git-send-email-briannorris@chromium.org>
 <20160616153817.GD21702@dell> <CAD=FV=X8eOQLbdAseL2_JwpOFNjSLDAi9hX=NrE=CfrrTZfAmA@mail.gmail.com>
 <20160617080635.GG21702@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160617080635.GG21702@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Brian Norris <briannorris@chromium.org>, Thierry Reding <thierry.reding@gmail.com>, Olof Johansson <olof@lixom.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Brian Norris <computersforpeace@gmail.com>, linux-pwm <linux-pwm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Stephen Barber <smbarber@chromium.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Benson Leung <bleung@chromium.org>, Enric Balletbo <enric.balletbo@collabora.co.uk>, Randall Spangler <rspangler@chromium.org>, Shawn Nematbakhsh <shawnn@chromium.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Todd Broch <tbroch@chromium.org>, Gwendal Grignou <gwendal@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>
List-Id: linux-pwm@vger.kernel.org

Lee,

On Fri, Jun 17, 2016 at 1:06 AM, Lee Jones <lee.jones@linaro.org> wrote:
>> Probably the reason for all of these non-kernel-isms is that this
>> isn't a kernel file.  From the top of the file:
>>
>>  * NOTE: This file is copied verbatim from the ChromeOS EC Open Source
>>  * project in an attempt to make future updates easy to make.
>>
>> So the source of truth for this file is
>> <https://chromium.googlesource.com/chromiumos/platform/ec/+/master/include/ec_commands.h>.
>>
>> Someone could probably submit a CL to that project to make it a little
>> more kernel-ish and then we'd have to see if the EC team would accept
>> such changes...
>
> Hmmm... that kinda puts me in a difficult position.  Do I except
> non-kernel code, which does not conform to our stands?

What about if Brian made sure to just fully copy the latest version of
"cros_ec_commands.h" from the EC codebase and changed this commit
message to say:

Copy the latest version of "cros_ec_commands.h" from the Chrome OS EC
code base, which is the source of truth for this file.  See
<https://chromium.googlesource.com/chromiumos/platform/ec/+/master/include/ec_commands.h>.

From the commit message it would be clear that this is an external
file linked into the kernel for convenience.


> Naturally I'd be happier if you could try to make the code more
> 'kernely'.  The practices I mention above are still good ones, even if
> you're not writing kernel specific code.

In general requesting that code from outside the kernel conform to
"kerneldoc" seems like a bit of a stretch.  In general having some
type of parse-able format for comments is nice, but I could see that
in the Chrome OS EC codebase it would be a bit overkill.


Also: it would be awfully strange if we suddenly started changing the
coding convention of this file or we had half the file in one
convention and half in another.  The rest of this file is in EC
convention and it seems sane to keep it that way...


-Doug
