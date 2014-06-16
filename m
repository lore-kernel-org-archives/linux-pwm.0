From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 0/2] backlight: remove trivial get_brightness
 implementations
Date: Mon, 16 Jun 2014 14:32:34 +0100
Message-ID: <20140616133234.GX14323@lee--X1>
References: <1401444650-12267-1-git-send-email-a.hajda@samsung.com>
 <000701cf895e$6a648f20$3f2dad60$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <000701cf895e$6a648f20$3f2dad60$%han@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Milo Kim' <milo.kim@ti.com>, "'open list:FRAMEBUFFER LAYER'" <linux-fbdev@vger.kernel.org>, 'Benjamin Herrenschmidt' <benh@kernel.crashing.org>, "'open list:X86 PLATFORM DRIVERS'" <platform-driver-x86@vger.kernel.org>, 'Andrzej Hajda' <a.hajda@samsung.com>, 'Thierry Reding' <thierry.reding@gmail.com>, 'Laurent Pinchart' <laurent.pinchart@ideasonboard.com>, 'Yijing Wang' <wangyijing@huawei.com>, 'Matthew Garrett' <matthew.garrett@nebula.com>, 'Kukjin Kim' <kgene.kim@samsung.com>, 'Sachin Kamat' <sachin.kamat@linaro.org>, 'Tomi Valkeinen' <tomi.valkeinen@ti.com>, 'Geert Uytterhoeven' <geert@linux-m68k.org>, 'Daniel Vetter' <daniel.vetter@ffwll.ch>, 'Jean-Christophe Plagniol-Villard' <plagnioj@jcrosoft.com>, 'Dan Carpenter' <dan.carpenter@oracle.com>, "'open list:PWM SUBSYSTEM'" <linux-pwm@vger.kernel.org>, 'Bryan Wu' <cooloney@gmail.com>, 'moderated list:ARM/S5P EXYN
List-Id: linux-pwm@vger.kernel.org

T24gTW9uLCAxNiBKdW4gMjAxNCwgSmluZ29vIEhhbiB3cm90ZToKCj4gT24gRnJpZGF5LCBNYXkg
MzAsIDIwMTQgNzoxMSBQTSwgQW5kcnplaiBIYWpkYSB3cm90ZToKPiA+IAo+ID4gVGhpcyBwYXRj
aHNldCBtYWtlcyBnZXRfYnJpZ2h0bmVzcyBjYWxsYmFjayBvcHRpb25hbAo+ID4gYW5kIHJlbW92
ZXMgdHJpdmlhbCBpbXBsZW1lbnRhdGlvbnMuCj4gPiBEcml2ZXIgY2hhbmdlcyBhcmUgcXVpdGUg
b2J2aW91cyBzbyBJIGhhdmUgcHV0IHRoZW0gaW50byBzaW5nbGUKPiA+IHBhdGNoLgo+ID4gCj4g
PiBUaGUgcGF0Y2hzZXQgaXMgYmFzZWQgb24gdGhlIGN1cnJlbnQgbGludXgtbmV4dCBicmFuY2gu
Cj4gPiAKPiA+IFJlZ2FyZHMKPiA+IEFuZHJ6ZWoKPiA+IAo+ID4gQW5kcnplaiBIYWpkYSAoMik6
Cj4gPiAgIGJhY2tsaWdodDogc2hvdyBicmlnaHRuZXNzIGV2ZW4gaWYgZ2V0X2JyaWdodG5lc3Mg
aXMgbm90IGltcGxlbWVudGVkCj4gPiAgIGJhY2tsaWdodDogcmVtb3ZlIHRyaXZpYWwgZ2V0X2Jy
aWdodG5lc3MgaW1wbGVtZW50YXRpb25zCj4gCj4gVGhlc2UgcGF0Y2hlcyBsb29rIGdvb2QhCj4g
QWNrZWQtYnk6IEppbmdvbyBIYW4gPGpnMS5oYW5Ac2Ftc3VuZy5jb20+Cj4gCj4gTGVlIEpvbmVz
LAo+IFdvdWxkIHlvdSBtZXJnZSB0aGVzZSBwYXRjaGVzIGludG8gYmFja2xpZ2h0IGdpdD8KClll
cCwgZG9uZS4KCk5COiBZb3UgZG9uJ3QgaGF2ZSB0byBhc2suICBJJ2xsIHNlZSB0aGF0IHlvdSd2
ZSByZXZpZXdlZC9hY2tlZCB0aGUKcGF0Y2hlcyBhbmQganVzdCBhcHBseSB0aGVtIGF1dG9tYXRp
Y2FsbHkgKHByb3ZpZGVkIEknbSBvbiB0aGUgQ0MgbGlzdApvZiBjb3Vyc2UpLgoKPiA+ICBkcml2
ZXJzL21hY2ludG9zaC92aWEtcG11LWJhY2tsaWdodC5jICAgICAgfCA2IC0tLS0tLQo+ID4gIGRy
aXZlcnMvcGxhdGZvcm0veDg2L3NhbXN1bmctcTEwLmMgICAgICAgICB8IDYgLS0tLS0tCj4gPiAg
ZHJpdmVycy92aWRlby9iYWNrbGlnaHQvYWF0Mjg3MF9ibC5jICAgICAgIHwgNiAtLS0tLS0KPiA+
ICBkcml2ZXJzL3ZpZGVvL2JhY2tsaWdodC9hbXMzNjlmZzA2LmMgICAgICAgfCA2IC0tLS0tLQo+
ID4gIGRyaXZlcnMvdmlkZW8vYmFja2xpZ2h0L2JhY2tsaWdodC5jICAgICAgICB8IDIgKysKPiA+
ICBkcml2ZXJzL3ZpZGVvL2JhY2tsaWdodC9iZDYxMDcuYyAgICAgICAgICAgfCA2IC0tLS0tLQo+
ID4gIGRyaXZlcnMvdmlkZW8vYmFja2xpZ2h0L2dwaW9fYmFja2xpZ2h0LmMgICB8IDYgLS0tLS0t
Cj4gPiAgZHJpdmVycy92aWRlby9iYWNrbGlnaHQvbGQ5MDQwLmMgICAgICAgICAgIHwgNiAtLS0t
LS0KPiA+ICBkcml2ZXJzL3ZpZGVvL2JhY2tsaWdodC9scDg1NXhfYmwuYyAgICAgICAgfCA2IC0t
LS0tLQo+ID4gIGRyaXZlcnMvdmlkZW8vYmFja2xpZ2h0L2xwODc4OF9ibC5jICAgICAgICB8IDYg
LS0tLS0tCj4gPiAgZHJpdmVycy92aWRlby9iYWNrbGlnaHQvbHY1MjA3bHAuYyAgICAgICAgIHwg
NiAtLS0tLS0KPiA+ICBkcml2ZXJzL3ZpZGVvL2JhY2tsaWdodC9wYW5kb3JhX2JsLmMgICAgICAg
fCA2IC0tLS0tLQo+ID4gIGRyaXZlcnMvdmlkZW8vYmFja2xpZ2h0L3B3bV9ibC5jICAgICAgICAg
ICB8IDYgLS0tLS0tCj4gPiAgZHJpdmVycy92aWRlby9iYWNrbGlnaHQvczZlNjNtMC5jICAgICAg
ICAgIHwgNiAtLS0tLS0KPiA+ICBkcml2ZXJzL3ZpZGVvL2JhY2tsaWdodC90cHM2NTIxN19ibC5j
ICAgICAgfCA2IC0tLS0tLQo+ID4gIGRyaXZlcnMvdmlkZW8vZmJkZXYvYXR5L2F0eTEyOGZiLmMg
ICAgICAgICB8IDYgLS0tLS0tCj4gPiAgZHJpdmVycy92aWRlby9mYmRldi9hdHkvYXR5ZmJfYmFz
ZS5jICAgICAgIHwgNiAtLS0tLS0KPiA+ICBkcml2ZXJzL3ZpZGVvL2ZiZGV2L2F0eS9yYWRlb25f
YmFja2xpZ2h0LmMgfCA2IC0tLS0tLQo+ID4gIGRyaXZlcnMvdmlkZW8vZmJkZXYvZXh5bm9zL3M2
ZThheDAuYyAgICAgICB8IDYgLS0tLS0tCj4gPiAgZHJpdmVycy92aWRlby9mYmRldi9udmlkaWEv
bnZfYmFja2xpZ2h0LmMgIHwgNiAtLS0tLS0KPiA+ICBkcml2ZXJzL3ZpZGVvL2ZiZGV2L3JpdmEv
ZmJkZXYuYyAgICAgICAgICAgfCA2IC0tLS0tLQo+ID4gIDIxIGZpbGVzIGNoYW5nZWQsIDIgaW5z
ZXJ0aW9ucygrKSwgMTIwIGRlbGV0aW9ucygtKQo+ID4gCj4gCgotLSAKTGVlIEpvbmVzCkxpbmFy
byBTVE1pY3JvZWxlY3Ryb25pY3MgTGFuZGluZyBUZWFtIExlYWQKTGluYXJvLm9yZyDilIIgT3Bl
biBzb3VyY2Ugc29mdHdhcmUgZm9yIEFSTSBTb0NzCkZvbGxvdyBMaW5hcm86IEZhY2Vib29rIHwg
VHdpdHRlciB8IEJsb2cKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2xpbnV4LWFybS1rZXJuZWwK
