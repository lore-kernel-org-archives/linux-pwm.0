From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v3 5/6] pwm: fsl-ftm: Don't update the state for the
 caller of pwm_apply_state()
Date: Tue, 3 Sep 2019 09:54:37 -0700
Message-ID: <CAD=FV=XFTuixKL-VBv-QObiO=Jg43i6W0enprLgXQ0U8=9C49A@mail.gmail.com>
References: <20190824153707.13746-1-uwe@kleine-koenig.org>
 <20190824153707.13746-6-uwe@kleine-koenig.org>
 <CAD=FV=X8kVU_zr69aKe-+GkAQh-tDwVf8tFogKve3s5O5ndF-g@mail.gmail.com>
 <20190902142709.wxrjsfzorozgeiuh@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20190902142709.wxrjsfzorozgeiuh-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-pwm <linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Patrick Havelange <patrick.havelange-buIOx9BAs4sybS5Ee8rs3A@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

SGksCgpPbiBNb24sIFNlcCAyLCAyMDE5IGF0IDc6MjcgQU0gVXdlIEtsZWluZS1Lw7ZuaWcKPHUu
a2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4gd3JvdGU6Cj4KPiBPbiBGcmksIEF1ZyAzMCwg
MjAxOSBhdCAxMDozOToxNkFNIC0wNzAwLCBEb3VnIEFuZGVyc29uIHdyb3RlOgo+ID4gSGksCj4g
Pgo+ID4gT24gU2F0LCBBdWcgMjQsIDIwMTkgYXQgODozNyBBTSBVd2UgS2xlaW5lLUvDtm5pZyA8
dXdlQGtsZWluZS1rb2VuaWcub3JnPiB3cm90ZToKPiA+ID4KPiA+ID4gVGhlIHB3bS1mc2wtZnRt
IGRyaXZlciBpcyBvbmUgb2Ygb25seSB0aHJlZSBQV00gZHJpdmVycyB3aGljaCB1cGRhdGVzCj4g
PiA+IHRoZSBzdGF0ZSBmb3IgdGhlIGNhbGxlciBvZiBwd21fYXBwbHlfc3RhdGUoKS4gVGhpcyBt
aWdodCBoYXZlCj4gPiA+IHN1cnByaXNpbmcgcmVzdWx0cyBpZiB0aGUgY2FsbGVyIHJldXNlcyB0
aGUgdmFsdWVzIGV4cGVjdGluZyB0aGVtIHRvCj4gPiA+IHN0aWxsIHJlcHJlc2VudCB0aGUgc2Ft
ZSBzdGF0ZS4KPiA+ID4KPiA+ID4gU2lnbmVkLW9mZi1ieTogVXdlIEtsZWluZS1Lw7ZuaWcgPHV3
ZUBrbGVpbmUta29lbmlnLm9yZz4KPiA+ID4gLS0tCj4gPiA+ICBkcml2ZXJzL3B3bS9wd20tZnNs
LWZ0bS5jIHwgNCAtLS0tCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgNCBkZWxldGlvbnMoLSkKPiA+
Cj4gPiBQcmVzdW1hYmx5IHRoaXMgcGF0Y2ggY291bGQgYnJlYWsgc29tZXRoaW5nIHNpbmNlIHRo
ZSBwd20tZnNsLWZ0bQo+ID4gZHJpdmVyIGRvZXNuJ3QgYXBwZWFyIHRvIGltcGxlbWVudCB0aGUg
Z2V0X3N0YXRlKCkgZnVuY3Rpb24uICAuLi5vcgo+ID4gZGlkIEkgbWlzcyBpdD8KPgo+IEkgZG9u
J3QgZXhwZWN0IGJyZWFrYWdlLiBXZSBoYXZlIG1vcmUgdGhhbiA1MCBwd20gZHJpdmVycyBhbmQg
b25seSB0aHJlZQo+IG9mIHRoZW0gbWFkZSB1c2Ugb2YgYWRhcHRpbmcgdGhlIHBhc3NlZCBzdGF0
ZS4gU28gdW5sZXNzIHlvdSBkbwo+IHNvbWV0aGluZyBzcGVjaWFsIHdpdGggdGhlIFBXTSAoaS5l
LiBtb3JlIHRoYW4gYmFja2xpZ2h0LCBMRUQgb3IgZmFuCj4gY29udHJvbCkgSSBkb24ndCB0aGlu
ayBhIGNvbnN1bWVyIG1pZ2h0IGNhcmUuIEJ1dCBpdCBtaWdodCB3ZWxsIGJlIHRoYXQKPiBJIG1p
c3Mgc29tZXRoaW5nIHNvIGZlZWwgZnJlZSB0byBwcm92ZSBtZSB3cm9uZy4KCkkgZG9uJ3QgaGF2
ZSB0aGlzIGhhcmR3YXJlIHNvIEkgY2FuJ3QgcHJvdmUgeW91IHdyb25nLiAgLi4uYnV0CnByZXN1
bWFibHkgc29tZW9uZSBhZGRlZCB0aGUgY29kZSB0byByZXR1cm4gdGhlIHN0YXRlIG9uIHB1cnBv
c2U/CgpNYXliZSB5b3UgY291bGQgaW1wbGVtZW50IGdldF9zdGF0ZSgpIGZvciB0aGlzIGRyaXZl
ciBpbiB5b3VyIHNlcmllcz8KCi1Eb3VnCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpMaW51eC1yb2NrY2hpcCBtYWlsaW5nIGxpc3QKTGludXgtcm9ja2No
aXBAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2xpbnV4LXJvY2tjaGlwCg==
