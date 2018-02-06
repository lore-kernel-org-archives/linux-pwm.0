From: Ulf Magnusson <ulfalizer@gmail.com>
Subject: Re: [PATCH v3 03/20] kconfig: Remove leftover references to AVR32 symbol
Date: Tue, 6 Feb 2018 23:58:34 +0100
Message-ID: <CAFkk2KSck-D0AiCgh3wQ4xL=Aozaah8CiPNn4V5-1VNZ9sLw_w@mail.gmail.com>
References: <20180205081151.GA11907@Red> <20180205190552.14282-1-ulfalizer@gmail.com>
 <20180206120825.GF5681@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180206120825.GF5681@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: corentin labbe <clabbe.montjoie@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Christophe Leroy <christophe.leroy@c-s.fr>, Sean Paul <seanpaul@chromium.org>, linux-spi@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Tue, Feb 6, 2018 at 1:08 PM, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Feb 05, 2018 at 08:05:39PM +0100, Ulf Magnusson wrote:
>> The AVR32 symbol was removed in commit 26202873bb51 ("avr32: remove
>> support for AVR32 architecture"). Remove the remaining references to it
>> from the Kconfig files.
>
>>  drivers/spi/Kconfig           | 2 +-
>>  drivers/video/console/Kconfig | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> It'd probably be easier to just submit these as separate patches to the
> individual subsystems, that'd make it more likely that reviewers will
> see them.  As I've no context for this I can't tell if there's any
> dependencies, I'm guessing not but just in case
>
> Acked-by: Mark Brown <broonie@kernel.org>

Done

https://lkml.org/lkml/2018/2/6/805
https://lkml.org/lkml/2018/2/6/808

Cheers,
Ulf
