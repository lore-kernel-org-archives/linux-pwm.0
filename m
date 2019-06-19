From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH v2] pwm: bcm2835: improve precision of pwm
Date: Wed, 19 Jun 2019 09:29:11 +0200
Message-ID: <59eed6bc-b99a-40b3-2dac-93dcbc7e922b@i2se.com>
References: <20190603090058.qd3tbiffmdgqm34d@gofer.mess.org>
 <1c7dc4ba-eb6e-b6da-3bfd-4b872f9c6498@gmx.net>
 <20190619072251.vhncrs2cnmtudrsj@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190619072251.vhncrs2cnmtudrsj@pengutronix.de>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, Stefan Wahren <wahrenst@gmx.net>
Cc: linux-pwm@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Sean Young <sean@mess.org>, Scott Branden <sbranden@broadcom.com>, Andreas Christ <andreas@christ-faesch.ch>, Ray Jui <rjui@broadcom.com>, Eric Anholt <eric@anholt.net>, Thierry Reding <thierry.reding@gmail.com>, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

SGkgVXdlLAoKT24gMTkuMDYuMTkgMDk6MjIsIFV3ZSBLbGVpbmUtS8O2bmlnIHdyb3RlOgo+IEhh
bGxvIFN0ZWZhbiwKPgo+IE9uIFdlZCwgSnVuIDE5LCAyMDE5IGF0IDA3OjIxOjQzQU0gKzAyMDAs
IFN0ZWZhbiBXYWhyZW4gd3JvdGU6Cj4+IEFtIDAzLjA2LjE5IHVtIDExOjAwIHNjaHJpZWIgU2Vh
biBZb3VuZzoKPj4+IElmIHNlbmRpbmcgSVIgd2l0aCBjYXJyaWVyIG9mIDQ1NWtIeiB1c2luZyB0
aGUgcHdtLWlyLXR4IGRyaXZlciwgdGhlCj4+PiBjYXJyaWVyIGVuZHMgdXAgYmVpbmcgNDc2a0h6
LiBUaGUgY2xvY2sgaXMgc2V0IHRvIGJjbTI4MzUtcHdtIHdpdGggYQo+Pj4gcmF0ZSBvZiAxME1I
ei4KPj4+Cj4+PiBBIGNhcnJpZXIgb2YgNDU1a0h6IGhhcyBhIHBlcmlvZCBvZiAyMTk4bnMsIGJ1
dCB0aGUgYXJpdGhtZXRpYyB0cnVuY2F0ZXMKPj4+IHRoaXMgdG8gMjEwMG5zIHJhdGhlciB0aGFu
IDIyMDBucy4gU28sIHVzZSBESVZfUk9VTkRfQ0xPU0VTVCgpIHRvIHJlZHVjZQo+Pj4gcm91bmRp
bmcgZXJyb3JzLCBhbmQgd2UgaGF2ZSBhIG11Y2ggbW9yZSBhY2N1cmF0ZSBjYXJyaWVyIG9mIDQ1
NC41a0h6Lgo+Pj4KPj4+IFJlcG9ydGVkLWJ5OiBBbmRyZWFzIENocmlzdCA8YW5kcmVhc0BjaHJp
c3QtZmFlc2NoLmNoPgo+Pj4gU2lnbmVkLW9mZi1ieTogU2VhbiBZb3VuZyA8c2VhbkBtZXNzLm9y
Zz4KPj4gQWNrZWQtYnk6IFN0ZWZhbiBXYWhyZW4gPHdhaHJlbnN0QGdteC5kZT4KPiB5b3UgYWxy
ZWFkeSBhY2tlZCB0aGF0IHdpdGggYSBzbGlnaHRseSBkaWZmZXJlbnQgbWFpbCBhZGRyZXNzIGEg
d2Vlawo+IGFnby4gV2FzIHRoaXMgaW50ZW5kZWQ/Cgp0aGFua3MuIFBsZWFzZSBpZ25vcmUgdGhp
cyBlbWFpbCB0aGlzIHdhcyBhIHR5cG8uIFRoZSBjb3JyZWN0IGRvbWFpbiB3YXMKZ214Lm5ldC4K
ClN0ZWZhbgoKPgo+IEJlc3QgcmVnYXJkcwo+IFV3ZQo+CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdAps
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVh
ZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
