Return-Path: <swarren@wwwdotorg.org>
Message-ID: <52096511.4000804@wwwdotorg.org>
Date: Mon, 12 Aug 2013 16:43:29 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
Subject: Re: [PATCH] pwm-backlight: add "max-brightness" property
References: <1376345057-29895-1-git-send-email-abrestic@chromium.org>
In-Reply-To: <1376345057-29895-1-git-send-email-abrestic@chromium.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-ID: <linux-pwm.vger.kernel.org>
To: Andrew Bresticker <abrestic@chromium.org>
Cc: Richard Purdie <rpurdie@rpsys.net>, Jingoo Han <jg1.han@samsung.com>, Olof Johansson <olof@lixom.net>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ian.campbell@citrix.com>, Rob Landley <rob@landley.net>, Thierry Reding <thierry.reding@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org

On 08/12/2013 04:04 PM, Andrew Bresticker wrote:
> Specifying each individual brightness value via the "brightness-levels"
> property can be a pain if we want to use a large continuous range of
> brightness values.  Add the property "max-brightness", which can be
> given in place of "brightness-levels", that specifies that all values
> between 0 and the given value can be used.

What about the non-linear nature of PWM duty cycle <-> (perceived)
brightness level? That's why the values are typically enumerated. I
guess if you use this new property, you'd use a value of say 16;
exposing levels 0..255 to a user is probably more than they want?
