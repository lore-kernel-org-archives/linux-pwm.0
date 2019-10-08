From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH 3/5] backlight: pwm_bl: drop use of int_pow()
Date: Tue, 8 Oct 2019 12:02:07 +0200
Message-ID: <9bf6baf9-46be-771c-7e26-527b117c998a@rasmusvillemoes.dk>
References: <20190919140620.32407-1-linux@rasmusvillemoes.dk>
 <20190919140620.32407-3-linux@rasmusvillemoes.dk>
 <20191007152800.3nhbf7h7knumriz4@holly.lan>
 <5f19e307-29c4-f077-568d-b2bd6ae74608@rasmusvillemoes.dk>
 <20191008093145.kgx6ytkbycmmkist@holly.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191008093145.kgx6ytkbycmmkist@holly.lan>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On 08/10/2019 11.31, Daniel Thompson wrote:
> On Mon, Oct 07, 2019 at 08:43:31PM +0200, Rasmus Villemoes wrote:
>> On 07/10/2019 17.28, Daniel Thompson wrote:
>>> On Thu, Sep 19, 2019 at 04:06:18PM +0200, Rasmus Villemoes wrote:
>>>
>>> It feels like there is some rationale missing in the description here.
>>>
>>
>> Apart from the function call overhead (and resulting register pressure
>> etc.), using int_pow is less efficient (for an exponent of 3, it ends up
>> doing four 64x64 multiplications instead of just two). But feel free to
>> drop it, I'm not going to pursue it further - it just seemed like a
>> sensible thing to do while I was optimizing the code anyway.
>>
>> [At the time I wrote the patch, this was also the only user of int_pow
>> in the tree, so it also allowed removing int_pow altogether.]
> 
> To be honest the change is fine but the patch description doesn't make
> sense if the only current purpose of the patch is as a optimization.

Agreed. Do you want me to resend the series with patch 3 updated to read

"For a fixed small exponent of 3, it is more efficient to simply use two
explicit multiplications rather than calling the int_pow() library
function: Aside from the function call overhead, its implementation
using repeated squaring means it ends up doing four 64x64 multiplications."

(and obviously patch 5 dropped)?

Rasmus
