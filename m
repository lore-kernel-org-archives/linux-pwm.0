From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH 3/5] backlight: pwm_bl: drop use of int_pow()
Date: Mon, 7 Oct 2019 20:43:31 +0200
Message-ID: <5f19e307-29c4-f077-568d-b2bd6ae74608@rasmusvillemoes.dk>
References: <20190919140620.32407-1-linux@rasmusvillemoes.dk>
 <20190919140620.32407-3-linux@rasmusvillemoes.dk>
 <20191007152800.3nhbf7h7knumriz4@holly.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191007152800.3nhbf7h7knumriz4@holly.lan>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Thompson <daniel.thompson@linaro.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On 07/10/2019 17.28, Daniel Thompson wrote:
> On Thu, Sep 19, 2019 at 04:06:18PM +0200, Rasmus Villemoes wrote:
> 
> It feels like there is some rationale missing in the description here.
> 
> What is the benefit of replacing the explicit int_pow() with the
> implicit multiplications?
> 
> 
> Daniel.
> 
> 
>>
>> We could (and a following patch will) change to use a power-of-2 scale,
>> but for a fixed small exponent of 3, there's no advantage in using
>> repeated squaring.

   ^^^^^^^^^^^^^^^^^^                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Apart from the function call overhead (and resulting register pressure
etc.), using int_pow is less efficient (for an exponent of 3, it ends up
doing four 64x64 multiplications instead of just two). But feel free to
drop it, I'm not going to pursue it further - it just seemed like a
sensible thing to do while I was optimizing the code anyway.

[At the time I wrote the patch, this was also the only user of int_pow
in the tree, so it also allowed removing int_pow altogether.]

Rasmus
