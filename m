From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v2 1/3] pwm: rockchip: Don't update the state for the
 caller of pwm_apply_state()
Date: Tue, 30 Apr 2019 07:38:09 -0700
Message-ID: <CAD=FV=WUi0NbsRDJA_4WeC62QYXjLNH2OygU1FOCx==W0SyqpQ@mail.gmail.com>
References: <20190312214605.10223-1-u.kleine-koenig@pengutronix.de>
 <20190312214605.10223-2-u.kleine-koenig@pengutronix.de>
 <1707507.TOMHpQGrZ7@phil>
 <CAD=FV=WZHouhGcxOgNG3006XajJQaAp0uq9WjeKRikQx1ru4TA@mail.gmail.com>
 <20190408143914.uucb5dwafq3cnsmk@pengutronix.de>
 <CA+ASDXO=szekU97iTDK9vqWjT+JtAKeCNTyoY=8aSi5d+v4mkA@mail.gmail.com>
 <20190429065613.n52uwgys5eugmssd@pengutronix.de>
 <CAD=FV=U71u39ZHkBBfAXVAP=_hY-bAw3L7JdhC=36jkUVxPOmQ@mail.gmail.com>
 <20190430092824.ijtq3gfh6mqujvnk@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20190430092824.ijtq3gfh6mqujvnk-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
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
Cc: linux-pwm <linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Boris Brezillon <boris.brezillon-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

SGksCgpPbiBUdWUsIEFwciAzMCwgMjAxOSBhdCAyOjI4IEFNIFV3ZSBLbGVpbmUtS8O2bmlnCjx1
LmtsZWluZS1rb2VuaWdAcGVuZ3V0cm9uaXguZGU+IHdyb3RlOgo+Cj4gPiA+IEFsc28gaXQgc2hv
dWxkIGJlIHBvc3NpYmxlIHRvIGtub3cgdGhlIHJlc3VsdCBiZWZvcmUgYWN0dWFsbHkKPiA+ID4g
Y29uZmlndXJpbmcgdGhlIGhhcmR3YXJlLiBPdGhlcndpc2UgdGhpbmdzIG1pZ2h0IGFscmVhZHkg
Z28gd3JvbmcKPiA+ID4gYmVjYXVzZSB0aGUgZHJpdmVyIGltcGxlbWVudHMgYSBzZXR0aW5nIHRo
YXQgaXMgdG9vIGZhciBmcm9tIHRoZQo+ID4gPiByZXF1ZXN0ZWQgY29uZmlndXJhdGlvbi4KPiA+
Cj4gPiBMYXRlciBpbiB0aGlzIHRocmVhZCBUaGllcnJ5IGRpZG4ndCBsaWtlIHRoZSAicm91bmQg
cmF0ZSIgaWRlYSBkdWUgdG8KPiA+IHJhY2VzLiAgT25lIHdheSB0byBzb2x2ZSB0aGF0IGNvdWxk
IGJlIHRvIGluZGljYXRlIHRvIHRoZSBQV00KPiA+IGZyYW1ld29yayB3aGljaCBkaXJlY3Rpb24g
eW91J2QgbGlrZSBpdCB0byBlcnJvciBpbjogYSBoaWdoZXIgZHV0eQo+ID4gY3ljbGUgb3IgYSBs
b3dlciBvbmUuCj4KPiBJIGRvbid0IHRoaW5rIHRoaXMgd291bGQgcmVzdWx0IGluIHNldHRpbmdz
IGFzIG9wdGltYWwgYXMgd2l0aCBteQo+IHN1Z2dlc3Rpb24uIElmIHlvdSBkb24ndCBhZ3JlZSBh
bmQgd2FudCB0byBjb252aW5jZSBtZTogU2hvdyBob3cgeW91cgo+IHN1Z2dlc3Rpb24gd291bGQg
d29yayB3aXRoIGEgUFdNIHRoYXQgY2FuIGltcGxlbWVudCBvbmx5IG11bHRpcGxlcyBvZiAzCj4g
Zm9yIGR1dHlfY3ljbGUgYW5kIHBlcmlvZCBhbmQgeW91IHdhbnQgMjAlIGR1dHkgY3ljbGUgd2l0
aCBwZXJpb2QgPD0gMQo+IG1zICh3aXRob3V0IG1ha2luZyB1c2Ugb2YgdGhlIGtub3dsZWRnZSBh
Ym91dCB0aGUgbGltaXRhdGlvbiBvZiB0aGUKPiBQV00gaW4gdGhlIGFsZ29yaXRobSkuCgpJIGd1
ZXNzIEkgd2FzIGFzc3VtaW5nIHRoYXQgc29tZWhvdyB0aGlzIHdvdWxkIHBlcmNvbGF0ZSBkb3du
IGludG8gYW4KQVBJIGNhbGwgdGhhdCB0aGUgUFdNIGRyaXZlciB3b3VsZCBpbXBsZW1lbnQsIHNv
IHlvdSBjb3VsZCBtYWtlIHVzZSBvZgp0aGUgUFdNIGtub3dsZWRnZSBpbiB0aGUgYWxnb3JpdGht
LgoKLi4uYnV0IEkgZG9uJ3QgaGF2ZSBhbnkgcmVhbCBzdHJvbmcgZmVlbGluZ3MgYWJvdXQgdGhp
cyBBUEkgc28gSSdsbApsZWF2ZSBpdCB0byB5b3UgYW5kIFRoaWVycnkgdG8gaGFzaCBvdXQgd2hh
dCBtYWtlcyB5b3UgYm90aCBoYXBweS4KCgotRG91ZwoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KTGludXgtcm9ja2NoaXAgbWFpbGluZyBsaXN0CkxpbnV4
LXJvY2tjaGlwQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9saW51eC1yb2NrY2hpcAo=
