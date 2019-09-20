From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH 1/5] backlight: pwm_bl: fix cie1913 comments and constant
Date: Fri, 20 Sep 2019 12:36:50 +0200
Message-ID: <fe846ffb-857e-fda2-1277-3ca49ffc0d7a@rasmusvillemoes.dk>
References: <20190919140620.32407-1-linux@rasmusvillemoes.dk>
 <20190920101405.yuu4bymublj45kd4@holly.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190920101405.yuu4bymublj45kd4@holly.lan>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On 20/09/2019 12.14, Daniel Thompson wrote:
> Hi Rasmus
> 
> Has something gone wrong with the mail out for this patch set. I didn't
> get a covering letter or patch 5/5?

Sorry about that. I should have included a cover letter so you'd know
that patch 5 wasn't directly related to the other patches.

https://lore.kernel.org/lkml/20190919140620.32407-5-linux@rasmusvillemoes.dk/

I was removing the now unused int_pow() function, but Andy has told me
there are new users in -next, so it's moot. Only the first four patches
are relevant.

Thanks,
Rasmus
