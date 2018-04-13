From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH RESEND] backlight: pwm_bl: don't use GPIOF_* with
 gpiod_get_direction
Date: Fri, 13 Apr 2018 17:26:44 +0100
Message-ID: <20180413162644.bej6yrgmqc2y3nfe@holly.lan>
References: <20180410123241.25745-1-wsa+renesas@sang-engineering.com>
 <20180411073215.fzvh4ejj2kd7wam3@verge.net.au>
 <20180413160824.GD31310@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20180413160824.GD31310@phenom.ffwll.local>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Simon Horman <horms@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-pwm@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, linux-fbdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
List-Id: linux-pwm@vger.kernel.org

T24gRnJpLCBBcHIgMTMsIDIwMTggYXQgMDY6MDg6MjRQTSArMDIwMCwgRGFuaWVsIFZldHRlciB3
cm90ZToKPiBPbiBXZWQsIEFwciAxMSwgMjAxOCBhdCAwOTozMjoxNkFNICswMjAwLCBTaW1vbiBI
b3JtYW4gd3JvdGU6Cj4gPiBPbiBUdWUsIEFwciAxMCwgMjAxOCBhdCAwMjozMjo0MFBNICswMjAw
LCBXb2xmcmFtIFNhbmcgd3JvdGU6Cj4gPiA+IFRoZSBkb2N1bWVudGF0aW9uIHdhcyB3cm9uZywg
Z3Bpb2RfZ2V0X2RpcmVjdGlvbigpIHJldHVybnMgMC8xIGluc3RlYWQKPiA+ID4gb2YgdGhlIEdQ
SU9GXyogZmxhZ3MuIFRoZSBkb2NzIHdlcmUgZml4ZWQgd2l0aCBjb21taXQgOTRmYzczMDk0YWJl
NDcKPiA+ID4gKCJncGlvOiBjb3JyZWN0IGRvY3MgYWJvdXQgcmV0dXJuIHZhbHVlIG9mIGdwaW9k
X2dldF9kaXJlY3Rpb24iKS4gTm93LAo+ID4gPiBmaXggdGhpcyB1c2VyICh1bnRpbCBhIGJldHRl
ciwgc3lzdGVtLXdpZGUgc29sdXRpb24gaXMgaW4gcGxhY2UpLgo+ID4gPiAKPiA+ID4gU2lnbmVk
LW9mZi1ieTogV29sZnJhbSBTYW5nIDx3c2ErcmVuZXNhc0BzYW5nLWVuZ2luZWVyaW5nLmNvbT4K
PiA+ID4gQWNrZWQtYnk6IERhbmllbCBUaG9tcHNvbiA8ZGFuaWVsLnRob21wc29uQGxpbmFyby5v
cmc+Cj4gPiAKPiA+IFJldmlld2VkLWJ5OiBTaW1vbiBIb3JtYW4gPGhvcm1zK3JlbmVzYXNAdmVy
Z2UubmV0LmF1Pgo+ID4gCj4gPiA+IC0tLQo+ID4gPiAKPiA+ID4gQ2hhbmdlcyBzaW5jZSBWMToK
PiA+ID4gCSogcmViYXNlZCB0byB0b3Atb2YtbGludXMtdHJlZQo+ID4gPiAJKiBhZGRlZCB0YWcg
ZnJvbSBEYW5pZWwsIHRoYW5rcyEKPiA+ID4gCj4gPiA+IFRocm91Z2ggd2hpY2ggdHJlZSBkb2Vz
IHRoaXMgbmVlZCB0byBnbz8KPiAKPiBJIHRoaW5rIERhbmllbCBUaG9tcHNvbiBoYXMgb25lIC4u
LgoKU29ycnksIEkgZGlkbid0IHNwb3QgdGhlIHF1ZXN0aW9uIGF0IHRoZSBib3R0b20gb2YgdGhl
IGNoYW5nZSBibG9jay4gCkZvciBiYWNrbGlnaHQgcGF0Y2hlcyBnZW5lcmFsbHkgZ28gdGhvdWdo
IExlZSBKb25lcycgdHJlZS4KCgpEYW5pZWwuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2RyaS1kZXZlbAo=
