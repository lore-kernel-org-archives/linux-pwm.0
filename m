From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v13 00/11] Convert PWM period and duty cycle
 to u64
Date: Fri, 24 Apr 2020 07:45:24 +0100
Message-ID: <20200424064524.GK3612@dell>
References: <cover.1587523702.git.gurus@codeaurora.org>
 <20200423114857.GG3612@dell> <20200423215306.GA8670@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20200423215306.GA8670@codeaurora.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Guru Das Srinagesh <gurus@codeaurora.org>
Cc: Kate Stewart <kstewart@linuxfoundation.org>, linux-fbdev@vger.kernel.org, David Collins <collinsd@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, David Airlie <airlied@linux.ie>, Michael Turquette <mturquette@baylibre.com>, Kamil Debski <kamil@wypas.org>, dri-devel@lists.freedesktop.org, Chris Wilson <chris@chris-wilson.co.uk>, Atish Patra <atish.patra@wdc.com>, linux-riscv@lists.infradead.org, Fabio Estevam <festevam@gmail.com>, linux-clk@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Alexander Shiyan <shc_work@mail.ru>, Chen-Yu Tsai <wens@csie.org>, NXP Linux Team <linux-imx@nxp.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Philipp Zabel <p.zabel@pengutronix.de>, Sascha Hauer <s.hauer@pengutronix.de>, Guenter Roeck <linux@roeck-us.net>, linux-media@vger.kernel.org, linux-pwm
List-Id: linux-pwm@vger.kernel.org

T24gVGh1LCAyMyBBcHIgMjAyMCwgR3VydSBEYXMgU3JpbmFnZXNoIHdyb3RlOgoKPiBPbiBUaHUs
IEFwciAyMywgMjAyMCBhdCAxMjo0ODo1N1BNICswMTAwLCBMZWUgSm9uZXMgd3JvdGU6Cj4gPiBX
aGF0J3MgdGhlIG1lcmdlIHBsYW4gZm9yIHRoaXMgc2V0Pwo+IAo+IEknbSBub3Qgc3VyZSB3aGF0
IHlvdSBtZWFuLiBNeSBhc3N1bXB0aW9uIGlzIHRoYXQgZmlyc3QgYWxsIHRoZSBwYXRjaGVzCj4g
bmVlZCB0byBnZXQgYW4gQWNrZWQtYnkgYW5kIG9ubHkgdGhlbiB3aWxsIHRoZSBzZXJpZXMgZ2V0
IGFwcGxpZWQgYnkKPiBUaGllcnJ5Li4uIENvdWxkIFRoaWVycnkgb3IgVXdlIHdlaWdoIGluIG9u
IHRoaXMgcG9pbnQgcGxlYXNlPwoKWWVzLCB0aGF0IGlzIHRoZSBtZXJnZSBwbGFuLiA6KQoKV2hv
ZXZlciB0YWtlcyB0aGlzIHdpbGwgaGF2ZSB0byBvZmZlciBvdXQgYW4gaW1tdXRhYmxlIFBSLgoK
LS0gCkxlZSBKb25lcyBb5p2O55C85pavXQpMaW5hcm8gU2VydmljZXMgVGVjaG5pY2FsIExlYWQK
TGluYXJvLm9yZyDilIIgT3BlbiBzb3VyY2Ugc29mdHdhcmUgZm9yIEFSTSBTb0NzCkZvbGxvdyBM
aW5hcm86IEZhY2Vib29rIHwgVHdpdHRlciB8IEJsb2cKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwtZ2Z4IG1haWxpbmcgbGlzdApJbnRlbC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vaW50ZWwtZ2Z4Cg==
