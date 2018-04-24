From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH RESEND] backlight: pwm_bl: don't use GPIOF_* with
 gpiod_get_direction
Date: Tue, 24 Apr 2018 11:07:23 +0100
Message-ID: <20180424100723.hyt3vxa2wp7sruqz@dell>
References: <20180410123241.25745-1-wsa+renesas@sang-engineering.com>
 <20180411073215.fzvh4ejj2kd7wam3@verge.net.au>
 <20180416091257.swbt7i6zjfbwysg2@dell>
 <20180424084124.6tpxf3ekadzefwd4@verge.net.au>
 <CAMuHMdWLya+=QeCwzszMxGPm7b3KbdsNFgc0vsk8NWC5tDO2QQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdWLya+=QeCwzszMxGPm7b3KbdsNFgc0vsk8NWC5tDO2QQ@mail.gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux PWM List <linux-pwm@vger.kernel.org>, Daniel Thompson <daniel.thompson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <horms@verge.net.au>, Thierry Reding <thierry.reding@gmail.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

T24gVHVlLCAyNCBBcHIgMjAxOCwgR2VlcnQgVXl0dGVyaG9ldmVuIHdyb3RlOgoKPiBPbiBUdWUs
IEFwciAyNCwgMjAxOCBhdCAxMDo0MSBBTSwgU2ltb24gSG9ybWFuIDxob3Jtc0B2ZXJnZS5uZXQu
YXU+IHdyb3RlOgo+ID4gT24gTW9uLCBBcHIgMTYsIDIwMTggYXQgMTA6MTI6NTdBTSArMDEwMCwg
TGVlIEpvbmVzIHdyb3RlOgo+ID4+IE9uIFdlZCwgMTEgQXByIDIwMTgsIFNpbW9uIEhvcm1hbiB3
cm90ZToKPiA+PiA+IE9uIFR1ZSwgQXByIDEwLCAyMDE4IGF0IDAyOjMyOjQwUE0gKzAyMDAsIFdv
bGZyYW0gU2FuZyB3cm90ZToKPiA+PiA+ID4gVGhlIGRvY3VtZW50YXRpb24gd2FzIHdyb25nLCBn
cGlvZF9nZXRfZGlyZWN0aW9uKCkgcmV0dXJucyAwLzEgaW5zdGVhZAo+ID4+ID4gPiBvZiB0aGUg
R1BJT0ZfKiBmbGFncy4gVGhlIGRvY3Mgd2VyZSBmaXhlZCB3aXRoIGNvbW1pdCA5NGZjNzMwOTRh
YmU0Nwo+ID4+ID4gPiAoImdwaW86IGNvcnJlY3QgZG9jcyBhYm91dCByZXR1cm4gdmFsdWUgb2Yg
Z3Bpb2RfZ2V0X2RpcmVjdGlvbiIpLiBOb3csCj4gPj4gPiA+IGZpeCB0aGlzIHVzZXIgKHVudGls
IGEgYmV0dGVyLCBzeXN0ZW0td2lkZSBzb2x1dGlvbiBpcyBpbiBwbGFjZSkuCj4gPj4gPiA+Cj4g
Pj4gPiA+IFNpZ25lZC1vZmYtYnk6IFdvbGZyYW0gU2FuZyA8d3NhK3JlbmVzYXNAc2FuZy1lbmdp
bmVlcmluZy5jb20+Cj4gPj4gPiA+IEFja2VkLWJ5OiBEYW5pZWwgVGhvbXBzb24gPGRhbmllbC50
aG9tcHNvbkBsaW5hcm8ub3JnPgo+ID4+ID4KPiA+PiA+IFJldmlld2VkLWJ5OiBTaW1vbiBIb3Jt
YW4gPGhvcm1zK3JlbmVzYXNAdmVyZ2UubmV0LmF1Pgo+ID4+Cj4gPj4gVGhhbmtzIGZvciB0aGUg
UmV2aWV3ZWQtYnkgU2ltb24uICBJIGhhdmUgYXBwbGllZCBpdCB0byB0aGUgb3JpZ2luYWwgbWFp
bC4KPiA+Pgo+ID4+IERvIHlvdSBrbm93IHdoeSB5b3UgbWFpbCB3YXNuJ3Qgc2VudCBhdHRhY2hl
ZCB0byB0aGUgb3JpZ2luYWwgdGhyZWFkPwo+ID4+IEZvciBzb21lIHJlYXNvbiBJIHJlY2VpdmVk
IHRoaXMgbWFpbCBvbiBpdCdzIG93biBpLmUuIG5vdCBpbiByZXBseQo+ID4+IHRvIHRoZSBvcmln
aW5hbC4KPiA+Cj4gPiBObywgbm90IG9mZiBoYW5kLiBQZXJoYXBzIEkgcmVzcG9uZGVkIHRvIHRo
ZSBlbWFpbCBpbiBzb21lIHVudXN1YWwgd2F5Cj4gPiBidXQgYnkgbm93IEkgZG9uJ3QgcmVjYWxs
LiBJbiBhbnkgY2FzZSBJJ2xsIHRyeSB0byBiZSBtb3JlIGNhcmVmdWwKPiA+IGluIGZ1dHVyZS4K
PiAKPiBJIHNlZSBMZWUgaXMgdXNpbmcgZ21haWwgZm9yIHNlbmRpbmcsIHNvIEkgYXNzdW1lIGFs
c28gZm9yIHJlY2VpdmluZy4KCldlbGwgSSdtIHVzaW5nIHRoZWlyIHNlcnZlcnMsIGJ1dCBteSBz
ZXQtdXAgaXMgSU1BUC9NdXR0LgoKPiBXaGlsZSBJIGRpZCByZWNlaXZlIFNpbW9uJ3MgcmVwbHkg
aW4tdGhyZWFkLCBsYXRlbHkgSSBoYWQgaXNzdWVzIHdpdGggZ21haWwKPiBub3QgYWx3YXlzIGRv
aW5nIHNvLCBhbmQgc29tZXRpbWVzIGZhaWxpbmcgdG8gZG8gZGVkdXBsaWNhdGlvbiB3aGVuIHJl
Y2VpdmluZwo+IGVtYWlsIHRocm91Z2ggbXVsdGlwbGUgcGF0aHMgKG1haWxpbmcgbGlzdHMgYW5k
L29yIGRpcmVjdGx5KS4KCi0tIApMZWUgSm9uZXMgW+adjueQvOaWr10KTGluYXJvIFNlcnZpY2Vz
IFRlY2huaWNhbCBMZWFkCkxpbmFyby5vcmcg4pSCIE9wZW4gc291cmNlIHNvZnR3YXJlIGZvciBB
Uk0gU29DcwpGb2xsb3cgTGluYXJvOiBGYWNlYm9vayB8IFR3aXR0ZXIgfCBCbG9nCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5n
IGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
